return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {"astro", "c", "lua", "vim", "bash", "bibtex", "c_sharp", "cmake", "cpp", "csv", "fortran", "gnuplot", "json", "julia", "make", "matlab", "ninja", "perl", "python", "rust", "sql", "ssh_config", "tcl", "tmux", "toml", "xml", "yaml", "latex"},
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
