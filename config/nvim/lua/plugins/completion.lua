return {
	{
		"saghen/blink.cmp",
		lazy = false,
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "super-tab" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
}
