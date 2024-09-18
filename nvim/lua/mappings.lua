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

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev localtion list" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = "Replace word under cursor",
})
-- map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, {
  expr = true,
  silent = true,
  desc = "Accept copilot completion",
})

map("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "DiffView open" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "DiffView close" })

del("n", "<c-h>")
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate Left" })
del("n", "<c-j>")
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate Down" })
del("n", "<c-k>")
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate Up" })
del("n", "<c-l>")
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate Right" })
del("n", "<c-\\>")
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate Previous" })

map("n", "[d", function()
  vim.diagnostic.goto_prev({ float = false })
  vim.cmd("normal! zz")
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.goto_next({ float = false })
  vim.cmd("normal! zz")
end, { desc = "Next diagnostic" })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
