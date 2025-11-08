return {
  -- add flexoki
  { "kepano/flexoki-neovim", name = "flexoki" },

  -- Configure LazyVim to load flexoki
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "flexoki",
    },
  },
}
