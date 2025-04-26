require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

-- del("n", "<ESC>")
map("i", "jk", "<ESC>")
map("i", "jj", "<Esc>", { noremap = true, silent = true })

map("i", "<C-s>", "<cmd>update<CR>", { desc = "Save file" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]], { desc = "Paste over visual selection" })

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", [["_d]])

map("n", "<leader>cq", "<cmd>cclose<CR>", { desc = "Close quickfix" })
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
map("n", "<leader>lq", "<cmd>lclose<CR>", { desc = "Close location list" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev localtion list" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = "Replace word under cursor",
})
map("v", "<leader>s", [[y:%s/\<<C-r><C-">\>/<C-r><C-">/gI<Left><Left><Left>]], {
  desc = "Replace word under visual selection",
})
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, {
  expr = true,
  silent = true,
  desc = "Accept copilot completion",
})

map("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "DiffView open" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "DiffView close" })

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = false, wrap = true })
  vim.cmd("normal! zz")
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = false, wrap = true })
  vim.cmd("normal! zz")
end, { desc = "Next diagnostic" })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP Code Actions" })
