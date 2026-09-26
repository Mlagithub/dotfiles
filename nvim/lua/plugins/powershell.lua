return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      local has_pwsh = vim.fn.executable("pwsh") == 1
      local has_powershell = vim.fn.executable("powershell.exe") == 1
      local shell = has_pwsh and "pwsh" or (has_powershell and "powershell.exe" or nil)

      local mason_bundle = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
      local has_bundle = vim.fn.isdirectory(mason_bundle) == 1

      if shell and has_bundle then
        opts.servers.powershell_es = {
          bundle_path = mason_bundle,
          shell = shell,
          init_options = {
            enableProfileLoading = false,
          },
        }
      else
        opts.servers.powershell_es = {
          enabled = false,
        }
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "powershell" })
      end
    end,
  },
}
