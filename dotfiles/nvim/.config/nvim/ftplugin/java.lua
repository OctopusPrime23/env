local jdtls = require "jdtls"
local home = os.getenv "HOME"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. (vim.fn.has "mac" == 1 and "mac" or "linux"),
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = false,
      },
      referencesCodeLens = {
        enabled = false,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      settings = {
        ["org.eclipse.jdt.core.formatter.tabulation.char"] = "space",
        ["org.eclipse.jdt.core.formatter.tabulation.size"] = "2",
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, { desc = "Organize imports", buffer = bufnr })
    vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, { desc = "Extract variable", buffer = bufnr })
    vim.keymap.set("v", "<leader>jv", function()
      jdtls.extract_variable(true)
    end, { desc = "Extract variable", buffer = bufnr })
    vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, { desc = "Extract constant", buffer = bufnr })
    vim.keymap.set("v", "<leader>jc", function()
      jdtls.extract_constant(true)
    end, { desc = "Extract constant", buffer = bufnr })
    vim.keymap.set("v", "<leader>jm", function()
      jdtls.extract_method(true)
    end, { desc = "Extract method", buffer = bufnr })
  end,

  capabilities = capabilities,

  init_options = {
    bundles = {
      vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
    },
  },
}

jdtls.start_or_attach(config)

local dap = require "dap"
dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
  {
    type = "java",
    request = "launch",
    name = "Debug (Launch) - Current File",
    mainClass = "${file}",
  },
}

