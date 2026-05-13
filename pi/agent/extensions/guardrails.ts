import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";
import * as path from "node:path";

// --- Command rules (bash tool) ---

interface CommandRule {
  name: string;
  pattern: RegExp;
}

const COMMAND_RULES: CommandRule[] = [
  // Destructive file ops
  { name: "rm", pattern: /\brm\s/ },
  { name: "rm-recursive", pattern: /\brm\s+(-rf?|--recursive)/ },
  { name: "rmdir", pattern: /\brmdir\b/ },
  { name: "shred", pattern: /\bshred\b/ },

  // Git push
  { name: "git-push", pattern: /\bgit\s+push\b/ },
  { name: "git-push-force", pattern: /\bgit\s+push\s+.*(--force|-f)/ },
  { name: "gt-submit", pattern: /\bgt\s+submit\b/ },
  { name: "gt-stack-submit", pattern: /\bgt\s+stack\s+submit\b/ },

  // Git rebase/merge
  { name: "git-rebase", pattern: /\bgit\s+rebase\b/ },
  { name: "git-merge", pattern: /\bgit\s+merge\b/ },

  // Git destructive
  { name: "git-reset-hard", pattern: /\bgit\s+reset\s+--hard\b/ },
  { name: "git-clean", pattern: /\bgit\s+clean\b.*-f/ },
  { name: "git-checkout-discard", pattern: /\bgit\s+checkout\s+--\s+\./ },
  { name: "gt-repo-sync-force", pattern: /\bgt\s+repo\s+sync\s+--force\b/ },
  { name: "gt-branch-delete-force", pattern: /\bgt\s+branch\s+delete\s+--force\b/ },
  { name: "gt-downstack-edit", pattern: /\bgt\s+downstack\s+edit\b/ },

  // Privilege escalation
  { name: "sudo", pattern: /\bsudo\b/ },
  { name: "su", pattern: /\bsu\s+-/ },

  // Permission changes
  { name: "chmod-777", pattern: /\bchmod\b.*777/ },
  { name: "chown-recursive", pattern: /\bchown\s+(-R|--recursive)/ },

  // Package publish
  { name: "npm-publish", pattern: /\bnpm\s+publish\b/ },
  { name: "gem-push", pattern: /\bgem\s+push\b/ },
  { name: "cargo-publish", pattern: /\bcargo\s+publish\b/ },

  // Rails destructive
  { name: "rails-db-drop", pattern: /\brails\s+db:drop\b/ },
  { name: "rails-db-reset", pattern: /\brails\s+db:reset\b/ },
  { name: "rake-db-drop", pattern: /\brake\s+db:drop\b/ },

  // Infra destructive
  { name: "kubectl-delete", pattern: /\bkubectl\s+delete\b/ },
  { name: "docker-rm", pattern: /\bdocker\s+rm\b/ },
];

// --- Path rules (read/write/edit tools) ---
// First match wins. Use "allow" to whitelist, "block" to deny, "confirm" to prompt.

type PathTool = "read" | "write" | "edit";

interface PathRule {
  name: string;
  tools: PathTool[];
  match: (resolved: string, cwd: string) => boolean;
  action: "allow" | "block" | "confirm";
}

const PATH_RULES: PathRule[] = [
  // Allow /tmp
  {
    name: "tmp-allow",
    tools: ["read", "write", "edit"],
    match: (p) => p.startsWith("/tmp/") || p === "/tmp",
    action: "allow",
  },
  // Block sensitive dotfiles
  {
    name: "block-env",
    tools: ["read"],
    match: (p) => path.basename(p) === ".env" || path.basename(p).startsWith(".env."),
    action: "block",
  },
  {
    name: "block-mise",
    tools: ["read"],
    match: (p) => path.basename(p).startsWith(".mise"),
    action: "block",
  },
  // Confirm writes outside cwd
  {
    name: "write-outside-cwd",
    tools: ["write", "edit"],
    match: (p, cwd) => !p.startsWith(cwd + path.sep) && p !== cwd,
    action: "confirm",
  },
];

export default function (pi: ExtensionAPI) {
  const sessionAllowlist = new Set<string>();

  pi.on("session_start", async () => {
    sessionAllowlist.clear();
  });

  // Single tool_call handler for all guardrails
  pi.on("tool_call", async (event, ctx) => {
    // --- Command guardrails (bash) ---
    if (isToolCallEventType("bash", event)) {
      const command = event.input.command;
      const matched = COMMAND_RULES.filter((r) => r.pattern.test(command));

      for (const rule of matched) {
        if (sessionAllowlist.has(rule.name)) continue;

        if (!ctx.hasUI) {
          return { block: true, reason: `Guardrail "${rule.name}" blocked (no UI for confirmation)` };
        }

        const choice = await ctx.ui.select(
          `⚠️ Guarded: ${rule.name}\n\n  ${command}\n`,
          ["Allow this once", `Allow "${rule.name}" for this session`, "Block"],
        );

        if (choice === `Allow "${rule.name}" for this session`) {
          sessionAllowlist.add(rule.name);
        } else if (choice !== "Allow this once") {
          return { block: true, reason: `Blocked by guardrail "${rule.name}"` };
        }
      }
    }

    // --- Path guardrails (read/write/edit) ---
    const toolName = event.toolName as PathTool;
    if (toolName === "read" || toolName === "write" || toolName === "edit") {
      const filePath = (event.input as { path?: string }).path;
      if (!filePath) return undefined;

      const resolved = path.resolve(ctx.cwd, filePath);
      const rule = PATH_RULES.find((r) => r.tools.includes(toolName) && r.match(resolved, ctx.cwd));

      if (!rule || rule.action === "allow") return undefined;

      if (rule.action === "block") {
        const guardKey = `${rule.name}:${resolved}`;
        if (sessionAllowlist.has(guardKey)) return undefined;

        if (!ctx.hasUI) {
          return { block: true, reason: `Guardrail "${rule.name}" blocked (no UI)` };
        }

        const choice = await ctx.ui.select(
          `🚫 Blocked: ${rule.name}\n\n  ${resolved}\n`,
          [`Allow "${rule.name}" for this file this session`, "Block"],
        );

        if (choice === `Allow "${rule.name}" for this file this session`) {
          sessionAllowlist.add(guardKey);
        } else {
          return { block: true, reason: `Blocked by guardrail "${rule.name}"` };
        }
      }

      if (rule.action === "confirm") {
        const resolvedDir = path.dirname(resolved);
        const guardKey = `${rule.name}:${resolvedDir}`;
        if (sessionAllowlist.has(guardKey)) return undefined;

        if (!ctx.hasUI) {
          return { block: true, reason: `Guardrail "${rule.name}" blocked (no UI)` };
        }

        const choice = await ctx.ui.select(
          `⚠️ Guarded: ${rule.name}\n\n  ${resolved}\n  (outside session root: ${ctx.cwd})\n`,
          ["Allow this once", `Allow "${rule.name}" for "${resolvedDir}" this session`, "Block"],
        );

        if (choice === `Allow "${rule.name}" for "${resolvedDir}" this session`) {
          sessionAllowlist.add(guardKey);
        } else if (choice !== "Allow this once") {
          return { block: true, reason: `Blocked by guardrail "${rule.name}"` };
        }
      }
    }

    return undefined;
  });

  // /guardrails command
  pi.registerCommand("guardrails", {
    description: "List guardrails and session overrides. Use '/guardrails reset' to clear overrides.",
    handler: async (args, ctx) => {
      if (args?.trim() === "reset") {
        sessionAllowlist.clear();
        ctx.ui.notify("Session allowlist cleared", "info");
        return;
      }

      const lines: string[] = [];

      lines.push("Command guardrails:");
      for (const rule of COMMAND_RULES) {
        const allowed = sessionAllowlist.has(rule.name) ? " (allowed for session)" : "";
        lines.push(`  ${rule.name}${allowed}`);
      }

      lines.push("");
      lines.push("Path guardrails:");
      for (const rule of PATH_RULES) {
        lines.push(`  ${rule.name} [${rule.action}] (${rule.tools.join(", ")})`);
      }

      const overrides = [...sessionAllowlist];
      if (overrides.length > 0) {
        lines.push("");
        lines.push(`Session overrides (${overrides.length}):`);
        for (const key of overrides) {
          lines.push(`  ${key}`);
        }
        lines.push(`Use '/guardrails reset' to clear.`);
      }

      ctx.ui.notify(lines.join("\n"), "info");
    },
  });
}
