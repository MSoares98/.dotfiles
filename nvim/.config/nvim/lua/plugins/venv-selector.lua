return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  branch = 'regexp',
  config = function()
    local venv_selector = require 'venv-selector'
    require('venv-selector').setup {
      auto_refresh = true,
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    }
  end,
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = "Select Python venv" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = "Select cached Python venv" },
  },
}
