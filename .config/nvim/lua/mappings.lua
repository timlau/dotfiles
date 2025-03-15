require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Buffer Save" })
map({ "n", "i", "v" }, "<C-x>", "<cmd> qa <cr>", { desc = "General Quit Neovim" })

-- use <Alt> <Up>/<Down> to move line up/down
map({ "n" }, "<A-Up>", "<cmd> m-2<CR>", { desc = "Move line up" })
map({ "n" }, "<A-Down>", "<cmd> m+<CR>", { desc = "Move line down" })
map({ "i" }, "<A-Up>", "<cmd> m-2<CR>", { desc = "Move line up" })
map({ "i" }, "<A-Down>", "<cmd> m+<CR>", { desc = "Move line down" })
map({ "v" }, "<A-Up>", "<cmd> m-2<CR>", { desc = "Move line up" })
map({ "v" }, "<A-Down>", "<cmd> m'>+<CR>", { desc = "Move line down" })
