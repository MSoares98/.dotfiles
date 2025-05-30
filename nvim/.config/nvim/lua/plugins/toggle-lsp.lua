return {
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
  config = function()
    require("toggle_lsp_diagnostics").init(vim.diagnostic.config())
    vim.keymap.set("n", "<Leader>tld", "<cmd>ToggleDiag<cr>", { desc = "Toggle diagnostics" })
  end,
}
