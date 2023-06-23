return {
	{
		"folke/flash.nvim",
		opts = {
			modes = {
				char = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"T",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
						mode = "char",
						search = {
							forward = false,
							mode = function(str)
								return "\\V" .. str .. "\\zs\\m."
							end,
						},
						jump = {
							autojump = true,
						},
						highlight = {
							matches = false,
							label = {
								style = "inline",
								before = false,
								after = { 0, 0 },
							},
						},
					})
				end,
				desc = "Flash",
			},
			{
				"t",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
						mode = "char",
						search = {
							mode = function(str)
								return "\\m.\\ze\\V" .. str
							end,
						},
						jump = {
							autojump = true,
						},
						highlight = {
							matches = false,
							label = {
								style = "inline",
								before = false,
								after = { 0, 0 },
							},
						},
					})
				end,
				desc = "Flash",
			},
			{
				"F",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
						mode = "char",
						search = {
							forward = false,
						},
						jump = {
							autojump = true,
						},
						highlight = {
							matches = false,
							label = {
								style = "inline",
								before = false,
								after = { 0, 0 },
							},
						},
					})
				end,
				desc = "Flash",
			},
			{
				"f",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
						mode = "char",
						search = {
							forward = true,
						},
						jump = {
							autojump = true,
						},
						highlight = {
							matches = false,
							label = {
								style = "inline",
								before = false,
								after = { 0, 0 },
							},
						},
					})
				end,
				desc = "Flash",
			},
		},
	},
}
