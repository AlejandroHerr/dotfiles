-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everforest_light",

  integrations = {
    gitsigns = true,
    telescope = true,
    nvimtree = true,
    whichkey = true,
    bufferline = true,
    dashboard = true,
    lualine = true,
    cmp = true,
    nvdash = true,
    lsp = true,
    lspkind_text = true,
    treesitter = true,
  },
  theme_toggle = { "everforest", "everforest" },
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  cmp = {
    lspkind_text = true,
  },
  nvdash = {
    load_on_startup = true,
  },
}
-- console log g fit signs
return M
