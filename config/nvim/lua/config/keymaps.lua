-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>bx", "<cmd>BufferLinePickClose<cr>", { desc = "Select Buffer to Close" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLinePick<cr>", { desc = "Select Buffer to Open" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close Buffers to Left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { desc = "Close Buffers to Right" })
vim.keymap.del({ "n", "x", "o" }, "s")
vim.keymap.del({ "n", "x", "o" }, "S")
-- stylua: ignore
vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<cr>", { desc = "Test Nearest" })
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test File" })
vim.keymap.set("n", "<leader>tF", "<cmd>TestSuite<cr>", {
	desc = "Test All Files",
})
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Run Last" })
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "Visit Test File" })
vim.keymap.set("n", "<leader>tk", "<cmd>VtrKillRunner<cr>", { desc = "Kill Runner Window" })
vim.keymap.set("n", "<leader>to", "<cmd>VtrOpenRunner<cr>", { desc = "Open Runner" })
vim.keymap.set("n", "<leader>tr", "<cmd>VtrFocusRunner<cr>", { desc = "Focus Runner" })
