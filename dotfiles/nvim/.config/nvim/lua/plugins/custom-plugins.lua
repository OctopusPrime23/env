return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {},
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "dap continue",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "dap toggle breakpoint",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "dap toggle repl",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "dap step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "dap step into",
      },
      {
        "<leader>dout",
        function()
          require("dap").step_out()
        end,
        desc = "dap step out",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "dap run last",
      },
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    init = function()
      require("dap-go").setup()
    end,
    keys = {
      {
        "<leader>dgt",
        function()
          require("dap-go").debug_test()
        end,
        "Debug go test",
      },
      {
        "<leader>dgl",
        function()
          require("dap-go").debug_last()
        end,
        "Debug last go test",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = function()
      local opts = require "nvchad.configs.treesitter"
      opts.ensure_installed = {
        -- mandatory
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        -- defaults
        "vim",
        "lua",
        "go",
        "rust",
        "java",
        "jq",
        "json5",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "gitignore",

        -- low level
        "c",
        "cpp",
        "zig",
      }

      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-m>",
          node_incremental = "<C-m>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }

      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      local opt = require "configs.nvim-treesitter-textobjects"
      require("nvim-treesitter.configs").setup(opt)
      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = { "VimBeGood" },
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      {
        "<leader>ea",
        function()
          require("harpoon"):list():add()
        end,
        desc = "harpoon add file",
      },
      {
        "<leader>em",
        function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon quick menu",
      },
      {
        "<leader>1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "harpoon to file 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "harpoon to file 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "harpoon to file 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "harpoon to file 4",
      },
      {
        "<leader>5",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "harpoon to file 5",
      },
      {
        "<leader>ep",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "harpoon to prev file",
      },
      {
        "<leader>en",
        function()
          require("harpoon"):list():next()
        end,
        desc = "harpoon to next file",
      },
    },
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ld", "<cmd>LazyDocker<cr>", desc = "LazyGit" },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  --[[
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
    end,
  },
    -]]
  -- {
  --   "mfussenegger/nvim-lint",
  --   config = function()
  --     lint.linters.golangcilint = {
  --       cmd = "golangci-lint",
  --       args = { "run", "--out-format", "json", "--issues-exit-code=1" },
  --       stdin = false,
  --       stream = "stdout",
  --       parser = require("lint.parser").from_errorformat("%f|%l col %c| %m", {
  --         source = "golangci-lint",
  --         severity_replace = {
  --           ["warning"] = vim.lsp.protocol.DiagnosticSeverity.Warning,
  --           ["error"] = vim.lsp.protocol.DiagnosticSeverity.Error,
  --         },
  --       }),
  --     }
  --
  --     -- run lint when saving go files
  --     vim.api.nvim_exec(
  --       [[
  --         augroup LintGo
  --           autocmd!
  --           autocmd BufWritePost *.go lua require('lint').try_lint()
  --         augroup END
  --       ]],
  --       false
  --     )
  --   end,
  -- },
  {

    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        -- javascript = { "eslint_d" },
        -- typescript = { "eslint_d" },
        -- javascriptreact = { "eslint_d" },
        -- typescriptreact = { "eslint_d" },
        -- svelte = { "eslint_d" },
        python = { "pylint" },
        go = { "golangcilint" },
      }
      -- golangci-lint run --out-format json --issues-exit-code=1
      -- lint.linters.golangcilint = {
      --   cmd = "golangci-lint",
      --   args = { "run", "--out-format", "json", "--issues-exit-code=1" },
      --   stdin = false,
      --   stream = "stdout",
      --   -- parser = require("lint.parser").from_errorformat("%f|%l col %c| %m", {
      --   --   source = "golangci-lint",
      --   --   severity_replace = {
      --   --     ["warning"] = vim.lsp.protocol.DiagnosticSeverity.Warning,
      --   --     ["error"] = vim.lsp.protocol.DiagnosticSeverity.Error,
      --   --   },
      --   -- }),
      -- }
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>li", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    event = "BufReadPost",
    config = require "configs.ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "auto:9" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    event = "BufEnter",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    enabled = false,
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-f>", -- accept the current suggestion in full
          accept_word = "<C-w>", -- accept the current word
          accept_line = "<C-l>", -- accept the current line
          -- Cycle through suggestions
          next = "<C-.>",
          prev = "<C-/>",
          dismiss = "<C-x>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        ["."] = true,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     local function copilot_indicator()
  --       local clients = vim.lsp.get_clients { name = "copilot" }
  --       local copilot_active = #clients > 0
  --       return copilot_active and "󰚩 " or ""
  --     end
  --     table.insert(opts.sections.lualine_x, 2, { copilot_indicator })
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources {
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/nvim-nio", -- Added vim-nio dependency
    },
    config = function()
      -- Get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"

      -- Get neotest-go
      local neotest = require "neotest"

      neotest.setup {
        -- Your neotest config here
        adapters = {
          require "neotest-go" {
            args = { "-v", "-timeout=20s" },
            recursive = true,
            discovery = {
              enabled = true,
              concurrent = true,
              filter_dir = function(name, rel_path, root)
                return name ~= "vendor" and name ~= "testdata"
              end,
            },
          },
        },
        -- Floating window for test output
        floating = {
          border = "rounded",
          max_height = 0.8,
          max_width = 0.8,
          options = {},
        },
        -- Icons for the test status
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✖",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✔",
          running = "↻",
          running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
          skipped = "ﰸ",
          unknown = "?",
        },
        -- Output handling
        output = {
          enabled = true,
          open_on_run = true,
        },
        -- Status handling
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
      }
    end,
    keys = {
      -- Run nearest test
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      -- Run current file
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand "%")
        end,
        desc = "Run test file",
      },
      -- Run all tests
      {
        "<leader>ta",
        function()
          local neotest = require "neotest"
          neotest.run.run {
            suite = true,
            extra_args = { "./..." },
          }
        end,
        desc = "Run all tests",
      },
      -- Stop nearest test
      {
        "<leader>ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop test",
      },
      -- Toggle output panel
      {
        "<leader>tp",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle test output panel",
      },
      -- Toggle summary window
      {
        "<leader>tt",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary",
      },
      -- Jump to next failed test
      {
        "<leader>tj",
        function()
          require("neotest").jump.next { status = "failed" }
        end,
        desc = "Jump to next failed test",
      },
      -- Jump to previous failed test
      {
        "<leader>tk",
        function()
          require("neotest").jump.prev { status = "failed" }
        end,
        desc = "Jump to previous failed test",
      },
      -- Show test output
      {
        "<leader>to",
        function()
          require("neotest").output.open { enter = true }
        end,
        desc = "Show test output",
      },
    },
  },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   enabled = false,
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup {
  --       api_key_cmd = "ansible-vault view --vault-password-file=/tmp/v ~/dotfiles/secrets.yaml | yq eval .open_ai_api_key",
  --     }
  --   end,
  --   dependencies = {
  --     -- Do not install NUI as well
  --     -- "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     -- do NOT install trouble, causes issues with nvchad's statusline
  --     -- "folke/trouble.nvim", -- optional
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
}
