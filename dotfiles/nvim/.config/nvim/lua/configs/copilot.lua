local M = {}
M.copilot = {
  i = {
    ["<C-;>"] = {
      function()
        vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
      end,
      "Copilot Accept",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
    -- ["<C-l>"] = {
    --   require("copilot.suggestion").accept(),
    --   "Copilot Accept",
    --   { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    -- },
  },
}

return M
