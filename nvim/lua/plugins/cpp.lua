return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      opts.handlers.codelldb = function()
        local dap = require("dap")
        local is_win = vim.fn.has("win32") == 1
        local mason_base = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
        local codelldb_path = mason_base .. (is_win and "/adapter/codelldb.exe" or "/adapter/codelldb")
        local liblldb_path = mason_base
          .. (
            is_win and "/lldb/bin/liblldb.dll"
            or (vim.fn.has("mac") == 1 and "/lldb/lib/liblldb.dylib" or "/lldb/lib/liblldb.so")
          )

        local args = { "--port", "${port}" }
        if vim.fn.filereadable(liblldb_path) == 1 then
          table.insert(args, 1, liblldb_path)
          table.insert(args, 1, "--liblldb")
        end

        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = codelldb_path,
            args = args,
            detached = false,
          },
        }
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      local is_win = vim.fn.has("win32") == 1
      local mason_base = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
      local codelldb_path = mason_base .. (is_win and "/adapter/codelldb.exe" or "/adapter/codelldb")
      local liblldb_path = mason_base
        .. (
          is_win and "/lldb/bin/liblldb.dll"
          or (vim.fn.has("mac") == 1 and "/lldb/lib/liblldb.dylib" or "/lldb/lib/liblldb.so")
        )

      local args = { "--port", "${port}" }
      if vim.fn.filereadable(liblldb_path) == 1 then
        table.insert(args, 1, liblldb_path)
        table.insert(args, 1, "--liblldb")
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = args,
          detached = false,
        },
      }

      local cpp_config = {
        {
          name = "Launch file (Debug)",
          type = "codelldb",
          request = "launch",
          program = function()
            -- 优先自动识别与当前 .cpp 同目录、同名的可执行文件
            local current_exe = vim.fn.expand("%:p:r") .. (is_win and ".exe" or "")
            if vim.fn.filereadable(current_exe) == 1 then
              return current_exe
            end
            return vim.fn.input("Path to executable: ", vim.fn.expand("%:p:h") .. "/", "file")
          end,
          cwd = "${fileDirname}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = cpp_config
      dap.configurations.c = cpp_config
    end,
  },
}
