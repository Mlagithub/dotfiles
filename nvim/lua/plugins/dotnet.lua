return {
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Filter out formatters requiring dotnet CLI if not available
      local filtered = {}
      for _, tool in ipairs(opts.ensure_installed) do
        if tool ~= "csharpier" and tool ~= "fantomas" then
          table.insert(filtered, tool)
        end
      end
      opts.ensure_installed = filtered
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fsautocomplete = {
          enabled = false,
        },
      },
    },
  },
}
