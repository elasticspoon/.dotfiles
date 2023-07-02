-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>bx", "<cmd>BufferLinePickClose<cr>", { desc = "Select Buffer to Close" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLinePick<cr>", { desc = "Select Buffer to Open" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close Buffers to Left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { desc = "Close Buffers to Right" })
-- stylua: ignore
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- centers search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search item (centered)." })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search item (centered)." })

-- moves line below to current line
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append line below to current line." })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "" })
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "gh", "g^", { desc = "" })
vim.keymap.set("n", "gl", "g$", { desc = "" })

-- Use tab for indenting in visual/select mode
vim.keymap.set("x", "<Tab>", ">gv|", { desc = "Indent Left" })
vim.keymap.set("x", "<S-Tab>", "<gv", { desc = "Indent Right" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })

vim.keymap.del("", "s")
vim.keymap.del("", "S")

vim.keymap.set({ "n", "x", "o" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Nav to window or tmux pane left." })
vim.keymap.set({ "n", "x", "o" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Nav to window or tmux pane right." })
vim.keymap.set({ "n", "x", "o" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Nav to window or tmux pane above." })
vim.keymap.set({ "n", "x", "o" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Nav to window or tmux pane below." })
vim.keymap.set({ "n", "x", "o" }, "<C-/>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Swap to prev. pane" })
