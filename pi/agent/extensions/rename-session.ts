/**
 * Rename session directly.
 *
 * Usage: /rename <session name>
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.registerCommand("rename", {
    description: "Rename session (usage: /rename <name>)",
    handler: async (args, ctx) => {
      let name = args.trim();

      if (!name) {
        const input = await ctx.ui.input("Session name:", "e.g. refactoring auth module");
        if (!input?.trim()) {
          ctx.ui.notify("Rename cancelled", "info");
          return;
        }
        name = input.trim();
      }

      pi.setSessionName(name);
      const cwd = require("node:path").basename(process.cwd());
      ctx.ui.setTitle(`π - ${name} - ${cwd}`);
      ctx.ui.notify(`Session renamed: ${name}`, "success");
    },
  });
}
