local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    fish = { "fish_indent" },
    templ = { "templ" },
    css = { "prettier" },
    json = { "prettier" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },
}

return options
