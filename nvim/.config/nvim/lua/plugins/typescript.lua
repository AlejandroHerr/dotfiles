return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              format = {
                insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
                insertSpaceAfterOpeningAndBeforeClosingEmptyBrackets = false,
              },
              javascript = {
                format = {
                  insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
                  insertSpaceAfterOpeningAndBeforeClosingEmptyBrackets = false,
                },
              },
            },
          },
        },
      },
    },
  },
}
