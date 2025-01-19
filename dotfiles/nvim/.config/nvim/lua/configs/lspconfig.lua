local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
-- local capabilities = require("nvchad.configs.lspconfig").capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "eslint",
  "clangd",
  "lua_ls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        appends = true,
        unusedparams = true,
        unusedvariable = true,
        nilness = true,
        unreachable = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
