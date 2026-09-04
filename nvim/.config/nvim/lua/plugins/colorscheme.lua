return {
  -- add gruvbox
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        snacks = true,
        telescope = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    -- specs = {
    --   {
    --     "akinsho/bufferline.nvim",
    --     optional = true,
    --     opts = function(_, opts)
    --       if (vim.g.colors_name or ""):find("catppuccin") then
    --         opts.highlights = require("catppuccin.special.bufferline").get_theme()
    --       end
    --     end,
    --   },
    -- },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
        -- rose-pine
        background = "hard",
        italics = true,
      })
    end,
  },
  -- lua/plugins/rose-pine.lua
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      disable_background = false,
      disable_float_background = false,
      transparency = false,
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          local highlights = require("rose-pine.plugins.bufferline")
          opts.highlights = highlights
        end,
      },
    },
    -- config = function()
    --   vim.cmd("colorscheme rose-pine")
    -- end,
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {

      -- colorscheme = "Catppuccin",
      -- colorscheme = "dracula",
      colorscheme = "rose-pine", -- change this to "gruvbox" to use gruvbox
    },
  },
}
