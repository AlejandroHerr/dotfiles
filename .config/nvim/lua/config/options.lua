-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.guicursor = ""
vim.opt.guicursor = {
  "n:block",
  "v:block",
  "i:block",
  "c:block",
}

vim.g.clipboard = "unnamedplus"
vim.o.winborder = "double"
