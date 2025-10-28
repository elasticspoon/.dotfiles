return {
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "super-tab",
			},
			completion = {
				ghost_text = { enabled = true },
				list = {
					selection = { preselect = false, auto_insert = false },
				},
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
