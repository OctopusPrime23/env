require "nvchad.options"

-- o.cursorlineopt ='both' -- to enable cursorline!
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.lsp.start {
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    }
  end,
})

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy "+",
    ["*"] = require("vim.ui.clipboard.osc52").copy "*",
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste "+",
    ["*"] = require("vim.ui.clipboard.osc52").paste "*",
  },
}

vim.opt.backupdir = os.getenv "HOME" .. "/.local/share/nvim/backups//"
vim.opt.backup = true

-- Add timestamp as extension for backup files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("timestamp_backupext", { clear = true }),
  desc = "Add timestamp to backup extension",
  pattern = "*",
  callback = function()
    vim.opt.backupext = "-" .. vim.fn.strftime "%Y%m%d%H%M"
  end,
})
