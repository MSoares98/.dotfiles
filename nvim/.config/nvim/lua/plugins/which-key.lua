return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
		local which_key = require("which-key")
		which_key.setup()
	end,
}
