return {
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        terminal = {
          position = "right",
          width = 0.3,
        },
      },
    },
    keys = {
      {
        "<c-i>",
        function()
          Snacks.terminal.toggle(nil, {
            cwd = LazyVim.root(),
            win = {
              position = "float",
              width = 0.6,
              height = 0.4,
              backdrop = false,
              border = "rounded",
            },
            env = {
              SNACKS_TERMINAL_TITLE = "Snacks Terminal",
            },
          })
        end,
        mode = { "n", "t" },
        desc = "Toggle Snacks Terminal",
      },
    },
  },
}
