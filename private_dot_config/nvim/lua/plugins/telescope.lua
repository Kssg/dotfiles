return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      opts.defaults = opts.defaults or {}
      -- 預設用 smart
      opts.defaults.path_display = { "smart" }

      --（可選）也調整 layout，提升可視寬度
      opts.defaults.layout_strategy = opts.defaults.layout_strategy or "horizontal"
      opts.defaults.layout_config = vim.tbl_deep_extend("force", opts.defaults.layout_config or {}, {
        horizontal = { width = 0.95, preview_width = 0.4 },
      })

      return opts
    end,
  },
}

