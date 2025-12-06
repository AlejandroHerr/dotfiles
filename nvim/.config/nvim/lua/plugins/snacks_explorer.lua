return {
  desc = "Snacks File Explorer",
  recommended = true,
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = { hidden = true },
        files = { hidden = true },
      },
    },
  },
  keys = {
    -- {
    --   "<leader>fe",
    --   function()
    --     Snacks.explorer({ cwd = LazyVim.root() })
    --   end,
    --   desc = "Explorer Snacks (root dir)",
    -- },
    -- {
    --   "<leader>fE",
    --   function()
    --     Snacks.explorer()
    --   end,
    --   desc = "Explorer Snacks (cwd)",
    -- },
    -- { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    -- { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
    { "<leader>e", false },
    { "<leader>E", false },
    {
      "<leader>e",
      function()
        local explorer_win = nil

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == "snacks_picker_list" then
            explorer_win = win
            break
          end
        end

        -- if vim.api.nvim_get_current_win() ~= explorer_win and explorer_win then
        if explorer_win then
          vim.api.nvim_set_current_win(explorer_win)
        else
          Snacks.explorer.open({ cwd = LazyVim.root() })
        end
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>E",
      function()
        local explorer_win = nil

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == "snacks_picker_list" then
            explorer_win = win
            break
          end
        end

        -- if vim.api.nvim_get_current_win() ~= explorer_win and explorer_win then
        if explorer_win then
          vim.api.nvim_set_current_win(explorer_win)
        else
          Snacks.explorer.open()
        end
      end,
      desc = "Explorer Snacks (cwd)",
    },
  },
}
