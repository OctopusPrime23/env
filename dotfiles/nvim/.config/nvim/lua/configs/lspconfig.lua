local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "eslint",
  "clangd",
  "lua_ls",
  "ts_ls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

vim.lsp.config("rust-analyzer", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
})
vim.lsp.enable "rust-analyzer"

-- gopls with custom config
vim.lsp.config("gopls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  -- root_dir = function(fname)
  --   -- First try go.work, then go.mod, fallback to .git
  --   local util = vim.fs
  --   return util.root(fname, { "go.work" }) or util.root(fname, { "go.mod" }) or util.root(fname, { ".git" })
  -- end,
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
      directoryFilters = {
        "-**/node_modules",
        "-**/vendor",
      },
    },
  },
})
vim.lsp.enable "gopls"

-- python with custom config
vim.lsp.config("basedpyright", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
      },
    },
  },
})
vim.lsp.enable "basedpyright"
