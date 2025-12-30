-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- map <C-z> to undo in normal mode
vim.keymap.set("n", "<C-z>", ":undo<CR>", { desc = "Undo" })

-- Optional: map <C-r> to redo in normal mode
vim.keymap.set("n", "<C-r>", ":redo<CR>", { desc = "Redo" })
