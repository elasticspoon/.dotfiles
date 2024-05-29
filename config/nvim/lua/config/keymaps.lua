-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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

-- stylua: ignore start
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.config/tmux/scripts/tmux-sessionizer<CR>", { desc = "Change Tmux Session" })
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })
-- stylua: ignore end
--
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

-- vim.keymap.del("n", "<c-/>")
-- vim.api.nvim_del_keymap("n", "<c-/>")
-- vim.api.nvim_del_keymap("n", "<C-/>")
-- vim.keymap.set({ "n", "x", "o" }, "<c-/>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Swap to prev. pane" })

-- stylua: ignore start
vim.keymap.set("n", "<leader>up", function() require("copilot.suggestion").toggle_auto_trigger() end, { desc = "Toggle Copilot Suggestion Autofill" })

-- vim.keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below", })
-- vim.keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above", })
-- stylua: ignore end

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
vim.keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
vim.keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

-- Don't yank on visual paste
vim.keymap.set({ "o", "x" }, "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-V>", [["+p"]], { desc = "paste from clipboard" })
-- magic search with /
vim.keymap.set("n", "/", [[/\v]])

-- Don't yank on delete char
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("v", "x", '"_x')
vim.keymap.set("v", "X", '"_X')

-- Start new line from any cursor position in insert-mode
-- cant get to work
-- vim.keymap.set("i", "<S-CR>", "<C-o>o", { desc = "Start Newline" })

vim.keymap.set("n", "<leader>e", ":Explore<cr>", { desc = "Show Current Dir" })
vim.keymap.set("n", "<leader>E", ":e .<cr>", { desc = "Show Root Dir" })

--move windows
-- vim.keymap.set("n", "<C-Left>", "<C-w>R", { desc = "Move split left" })
-- vim.keymap.set("n", "<C-Right>", "<C-w>r", { desc = "Move split right" })
-- vim.keymap.set("n", "<C-Down>", "<C-w>r", { desc = "Move split down" })
-- vim.keymap.set("n", "<C-Up>", "<C-w>R", { desc = "Move split up" })
--

-- stylua: ignore start
-- Random Custom Snippets
vim.keymap.set( "n", "<leader>Zb", ":source ~/.config/nvim/scipts/blog_formatting.vim<cr>", { desc = "Format Blog" })
-- stylua: ignore end

vim.keymap.set("i", "<M-]>", function()
	require("copilot.sugestion").next()
end)
