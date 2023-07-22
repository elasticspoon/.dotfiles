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

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into clipboard" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Change Tmux Session" })
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- Use tab for indenting in visual/select mode
vim.keymap.set("x", "<Tab>", ">gv|", { desc = "Indent Left" })
vim.keymap.set("x", "<S-Tab>", "<gv", { desc = "Indent Right" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })

-- vim.keymap.del("", "s")
-- vim.keymap.del("", "S")

vim.keymap.set({ "n", "x", "o" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Nav to window or tmux pane left." })
vim.keymap.set({ "n", "x", "o" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Nav to window or tmux pane right." })
vim.keymap.set({ "n", "x", "o" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Nav to window or tmux pane above." })
vim.keymap.set({ "n", "x", "o" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Nav to window or tmux pane below." })
vim.keymap.set({ "n", "x", "o" }, "<C-/>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Swap to prev. pane" })

-- stylua: ignore start
vim.keymap.set("n", "<leader>uC", function() require("copilot.suggestion").toggle_auto_trigger() end, { desc = "Toggle Copilot Suggestion Autofill" })

vim.keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below", })
vim.keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above", })
-- stylua: ignore end

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
vim.keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
vim.keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

-- magic search with /
vim.keymap.set("n", "/", [[/\v]])

-- Don't yank on delete char
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("v", "x", '"_x')
vim.keymap.set("v", "X", '"_X')

-- Don't yank on visual paste
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Start new line from any cursor position in insert-mode
vim.keymap.set("i", "<S-Return>", "<C-o>o", { desc = "Start Newline" })

-- Use backspace key for matching parens
vim.keymap.set({ "n", "x" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

--move windows
vim.keymap.set("n", "<C-H>", "<C-w>R", { desc = "Move split left" })
vim.keymap.set("n", "<C-L>", "<C-w>r", { desc = "Move split right" })
vim.keymap.set("n", "<C-J>", "<C-w>r", { desc = "Move split down" })
vim.keymap.set("n", "<C-K>", "<C-w>R", { desc = "Move split up" })
