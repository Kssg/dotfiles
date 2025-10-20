return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "lua", "vim", "vimdoc",
          "markdown", "markdown_inline", "bash", "json", "yaml"
        },
        highlight = { enable = true },
      })
    end
  },
}

