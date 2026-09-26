-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.has("win32") == 1 then
  -- Windows 平台下添加 /d 参数，防止 cmd.exe 自动执行注册表中的 AutoRun (例如 chcp 65001)
  -- 避免外部格式化工具 (如 stylua/prettier) 输出被污染并注入到文件首行
  vim.opt.shellcmdflag = "/d /s /c"
end
