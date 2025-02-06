local configs = require("nvchad.configs.lspconfig")
local conform = require("conform")

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
  html = {
    filetypes = { "html", "templ" },
  },
  bashls = {},
  intelephense = {},
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
  yamlls = {
    settings = {
      yaml = {
        -- schemas = {
        --   ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        --   ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
        --   ["https://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
        --   ["https://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
        --   ["https://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        --   ["https://json.schemastore.org/ansible-stable-2.10"] = "roles/tasks/*.{yml,yaml}",
        --   ["https://json.schemastore.org/ansible-stable-2.8"] = "roles/tasks/*.{yml,yaml}",
        --   ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "compose*.{yml,yaml}",
        --   -- ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/docker-compose.json"] = "docker-compose*.{yml,yaml}",
        --   ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/dockerfile.json"] = "Dockerfile*",
        -- },
        format = {
          enable = true,
        },
        validate = true,
        completion = true,
        hover = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
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
        -- "--enable-all",
        -- "--disable",
        -- "lll",
        "--out-format",
        "json",
        "--issues-exit-code=1",
      },
    },
    flags = {
      debounce_text_changes = 150,
      exit_timeout = 0, -- Disable exit timeout
    },
  },
  eslint = {
    on_attach = function(client, bufnr)
      -- Enable ESLint formatting
      client.server_capabilities.documentFormattingProvider = true

      -- Run EslintFixAll before conform formatting
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
  ts_ls = {
    settings = {
      typescript = {
        format = {
          insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
          insertSpaceAfterOpeningAndBeforeClosingEmptyBrackets = false,
        },
      },
    },
  },
  tailwindcss = {
    filetypes = { "templ", "astro", "javascript", "typescript", "react", "javascriptreact", "typescriptreact" },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    -- First run LSP formatting
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "eslint"
      end,
      async = false,
    })

    -- Then run conform formatting
    conform.format({ bufnr = args.buf })
  end,
})
