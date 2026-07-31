-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<CR>", "o<Esc>", { desc = "Open Line Below" })
map("n", "<S-CR>", "O<Esc>", { desc = "Open Line Above" })
map("n", "<C-c>", "ciw", { desc = "Change Inner Word" })

map("i", "<A-l>", "<Esc>la", { desc = "Move Right" })
map("i", "<A-h>", "<Esc>ha", { desc = "Move Left" })
map("i", "<C-x>", "<BS>", { desc = "Backspace" })

map({ "n", "x", "o" }, "H", "^", { desc = "First Non-Blank" })
map({ "n", "x", "o" }, "L", "$", { desc = "End Of Line" })
