-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {

  theme = "palenight",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}
M.mason = {
  cmd = true,
  pkgs = {
    "bash-language-server",
    "basedpyright",
    "black",
    "checkstyle",
    "clang-format",
    "clangd",
    "codespell",
    "css-lsp",
    "delve",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "eslint-lsp",
    "eslint_d",
    "gofumpt",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "google-java-format",
    "gopls",
    "html-lsp",
    "isort",
    "java-debug-adapter",
    "jdtls",
    "jq",
    "jq-lsp",
    "json-lsp",
    "lua-language-server",
    "prettier",
    "prettierd",
    "pylint",
    "rust-analyzer",
    "staticcheck",
    "stylua",
    "tailwindcss-language-server",
    "typescript-language-server",
  },
}

return M
