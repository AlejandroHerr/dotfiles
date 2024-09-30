return {
  {
    "github/copilot.vim",
    lazy = false,
    keys = {
      {
        "n",
        "<C-k>",
        '<cmd>lua vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")<CR>',
        { noremap = true, silent = true },
      },
    },
    config = function()
      vim.g.copilot_no_tab_map = true
    end,
  },
}
