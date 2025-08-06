return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "astro",
          "tailwindcss",
          "jsonls",
          "yamlls",
          "bashls",
          "pyright",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local util = require("lspconfig/util")
      local path = util.path

      local lspconfig = require("lspconfig")
      lspconfig.astro.setup({
        capabilities = capabilities,
        filetypes = { "astro" },
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities
      })
      lspconfig.bashls.setup({
        capabilities = capabilities
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = vim.fn.exepath("python3"),
          },
        },
        on_new_config = function(new_config, dir)
          if require("util").dir_has_file(dir, "poetry.lock") then
            vim.notify_once("Running `pyright` with `poetry`")
            new_config.cmd = { "poetry", "run", "pyright-langserver", "--stdio" }
          elseif require("util").dir_has_file(dir, "Pipfile") then
            vim.notify_once("Running `pyright` with `pipenv`")
            new_config.cmd = { "pipenv", "run", "pyright-langserver", "--stdio" }
          else
            vim.notify_once("Running `pyright` without a virtualenv")
          end
        end,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
      vim.keymap.set("n", "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Find references" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

      vim.lsp.inlay_hint.enable(true)  -- Enable inlay hints for LSP

      -- Add to your lsp-config.lua file within the config function
      vim.diagnostic.config({
        virtual_text = true,       -- Show diagnostics as virtual text
        signs = true,              -- Show signs in the sign column
        underline = true,          -- Underline text with diagnostics
        update_in_insert = true,   -- Update diagnostics in insert mode
        severity_sort = true,      -- Sort diagnostics by severity
      })
    end,
  },
}
