return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      local is_win = vim.fn.has("win32") == 1
      local mason_bin = vim.fn.stdpath("data")
        .. (is_win and "/mason/packages/cmake-language-server/venv/Scripts/cmake-language-server.exe" or "/mason/packages/cmake-language-server/venv/bin/cmake-language-server")

      local cmd = vim.fn.filereadable(mason_bin) == 1 and { mason_bin } or { "cmake-language-server" }

      opts.servers.cmake = {
        cmd = cmd,
        filetypes = { "cmake" },
        root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake", "CMakeLists.txt" },
        init_options = {
          buildDirectory = "build",
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "cmake" })
      end
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cmake-language-server" })
    end,
  },
}
