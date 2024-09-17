return {
  {
    "github/copilot.vim",
    lazy = false,
    keys = {
      {
        "n",
        "<C-l>",
        '<cmd>lua vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")<CR>',
        { noremap = true, silent = true },
      },
    },
  },
}
