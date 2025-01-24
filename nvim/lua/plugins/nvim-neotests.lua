return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
  },
  lazy = false,
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({
          recursive = true,
        }), -- Registration
      },
    })

    vim.api.nvim_set_keymap(
      "n",
      "<leader>tr",
      ':lua require("neotest").run.run()<CR>',
      { noremap = true, silent = true, desc = "Run test" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>ts",
      ':lua require("neotest").run.stop()<CR>',
      { noremap = true, silent = true, desc = "Stop test" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>tt",
      ':lua require("neotest").summary.toggle()<CR>',
      { noremap = true, silent = true, desc = "Show test summary" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>to",
      ':lua require("neotest").output.open()<CR>',
      { noremap = true, silent = true, desc = "Open test output" }
    )
  end,
}
