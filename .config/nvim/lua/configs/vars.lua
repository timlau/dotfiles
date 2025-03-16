return {
  -- Mason tools to install
  mason_tool_installer = {
    "ruff",
    "stylelua",
    "prettier",
  },
  -- Mason LSP to setup
  mason_lspconfig = {
    "html",
    "cssls",
    "lua_ls",
    "ruff",
    "autotools_ls",
    "markdown_oxide",
  },
  -- LSP Servers to setup
  lsp_servers = {
    bashls = {},
    ruff = {},
    autotools_ls = {},
    markdown_oxide = {},
    clangd = {},
    ansiblels = {},
  },
}
