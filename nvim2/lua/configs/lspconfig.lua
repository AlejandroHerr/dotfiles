local configs = require("nvchad.configs.lspconfig")

-- local signs = {
--   Error = "",
--   Warn  = " ",
--   Info  = "󰛩 ",
--   Hint  = "󰋼 ",
-- }
--
-- local signs = {
--   Error = "▌",
--   Warn  = "▌",
--   Info  = "▌",
--   Hint  = "▌",
-- }
--
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
--
--
local function configure_diagnostic_signs()
  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
end

-- Hook into NvChad theme reload
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    configure_diagnostic_signs()
  end,
})

-- Apply diagnostic signs when starting up as well
configure_diagnostic_signs()

-- Configure diagnostic settings
vim.diagnostic.config({
  virtual_text = true, -- Disable virtual text if preferred
  signs = true, -- Enable signs in the gutter
  underline = true,
  -- update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded", -- Border style for floating diagnostics
    source = true, -- Show source of the diagnostic
  },
})

local servers = {
  html = {},
  awk_ls = {},
  bashls = {},
  docker_compose_language_service = {},
  dockerls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
  gopls = {
    root_dir = require("lspconfig").util.root_pattern("go.mod", ".git"),
    cmd = { "gopls" },
    filetypes = { "go", "gomod" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          unreachable = true,
          shadow = true,
        },
        completeUnimported = true, -- Complete imports automatically
        gofumpt = true, -- Use gofumpt formatting
        staticcheck = true, -- Enable static checks
        usePlaceholders = true, -- Use placeholders for function arguments
      },
    },
  },
  golangci_lint_ls = {
    filetypes = { "go", "gomod" },
    cmd = { "golangci-lint-langserver" },
    root_dir = require("lspconfig").util.root_pattern(".git", "go.mod"),
    init_options = {
      command = {
        "golangci-lint",
        "run",
        "--enable-all",
        "--disable",
        "lll",
        "--out-format",
        "json",
        "--issues-exit-code=1",
      },
    },
  },
  eslint = {},
  ts_ls = {
    settings = {
      typescript = {
        insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingEmptyBrackets = false
      },
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
