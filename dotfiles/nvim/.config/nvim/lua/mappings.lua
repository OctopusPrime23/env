require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local wo = vim.wo
local km = vim.keymap

map("n", ";", ":", { desc = "CMD enter command mode" })

wo.relativenumber = true

km.set("i", "jk", "<Esc>")
km.set("i", "kj", "<Esc>")
km.set("v", "jk", "<Esc>")
km.set("v", "kj", "<Esc>")

km.set("n", "dw", "diw")
km.set("n", "dW", "diW")
km.set("n", "<leader>dw", "dw")
km.set("n", "<leader>dW", "dW")
km.set("n", "cw", "ciw")
km.set("n", "cW", "ciW")
km.set("n", "<leader>cw", "cw")
km.set("n", "<leader>cW", "cW")

km.set("n", "<leader>-", "<cmd>b#<CR>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

km.del("n", "<leader>e")
km.set("v", "<C-r>", ":w !bash<CR>", { desc = "execute selected lines in bash" })

km.set("n", "<A-k>", "ddkP", { desc = "move line up" })
km.set("n", "<A-j>", "ddp", { desc = "move line down" })

map("n", "[m", "[mzz", { noremap = true, silent = true })
map("n", "[M", "[Mzz", { noremap = true, silent = true })
map("n", "]m", "]mzz", { noremap = true, silent = true })
map("n", "[M", "[Mzz", { noremap = true, silent = true })

km.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand "%:p")
end, { desc = "Copy full path of current buffer" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.15,
      col = 0.05,
      width = 0.9,
      height = 0.7,
      border = "rounded",
    },
  }
end, { desc = "terminal toggle floating term" })

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "d", api.fs.trash, { buffer = bufnr, desc = "Trash" })
  vim.keymap.set("n", "D", api.fs.remove, { buffer = bufnr, desc = "Delete" })
end

-- Use this in your nvim-tree setup
require("nvim-tree").setup {
  on_attach = on_attach,
}
