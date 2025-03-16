return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = function()
    -- import mason-lspconfig
    local mason_lspconfig = require "mason-lspconfig"
    local mason_tool_installer = require "mason-tool-installer"
    mason_lspconfig.setup {
      -- list of servers for mason to install
      ensure_installed = require("configs.vars").mason_lspconfig,
    }

    mason_tool_installer.setup {
      ensure_installed = require("configs.vars").mason_tool_installer,
    }
    return require "nvchad.configs.mason"
  end,
}
