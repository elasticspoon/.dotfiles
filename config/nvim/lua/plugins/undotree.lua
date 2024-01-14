return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })
			vim.g["undotree_WindowLayout"] = 2
			vim.g["undotree_DiffpanelHeight"] = 20
			vim.g["undotree_SplitWidth"] = 45
			vim.g["undotree_SetFocusWhenToggle"] = 1
		end,
	},
}
