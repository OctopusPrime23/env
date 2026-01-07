-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {

  theme = "onedark",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}
M.mason = {
  cmd = true,
  pkgs = {
    "bash-language-server",
    "clangd",
    "clang-format",
    "dockerfile-language-server",
    "docker-compose-language-service",
    "delve",
    "eslint-lsp",
    "goimports-reviser",
    "gofumpt",
    "golangci-lint",
    "golangci-lint-langserver",
    "gopls",
    "json-lsp",
    "jq",
    "jq-lsp",
    "rust-analyzer",
    "staticcheck",
    "tailwindcss-language-server",
    "typescript-language-server",
    "prettier",
    "prettierd",
    "lua-language-server",
    "jdtls",
    "google-java-format",
    "checkstyle",
    "java-debug-adapter",
  },
}

return M
