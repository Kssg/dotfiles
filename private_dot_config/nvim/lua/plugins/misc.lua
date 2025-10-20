return {
  -- 自動補全括號，進入 Insert 模式時才載入
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- 註解插件：gcc / gc 可快速註解
  { "tpope/vim-commentary" },

  -- 操作括號、引號的神器：cs, ds, ys
  { "tpope/vim-surround" },

  -- Git 整合，:Gdiffsplit / :Gstatus / :Gblame
  { "tpope/vim-fugitive" },
}

