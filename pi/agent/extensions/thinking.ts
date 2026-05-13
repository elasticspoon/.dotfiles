import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { StringEnum } from "@mariozechner/pi-ai";
import { Type } from "@sinclair/typebox";

const LEVELS = ["medium", "high", "xhigh"] as const;
const MIN_LEVEL = "medium";

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "set_thinking",
    label: "Set Thinking",
    description: `Set the thinking/reasoning level. Valid levels: ${LEVELS.join(", ")}. Minimum is ${MIN_LEVEL}.`,
    parameters: Type.Object({
      level: StringEnum([...LEVELS], {
        description: `Thinking level (${LEVELS.join(", ")})`,
      }),
    }),
    async execute(toolCallId, params) {
      pi.setThinkingLevel(params.level);
      const effective = pi.getThinkingLevel();

      const clamped = effective !== params.level
        ? ` (clamped to "${effective}" — model may not support requested level)`
        : "";

      return {
        content: [{ type: "text", text: `Thinking level set to: ${effective}${clamped}` }],
        details: {},
      };
    },
  });
}
