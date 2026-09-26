-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.has("win32") == 1 then
  -- Windows 平台下添加 /d 参数，防止 cmd.exe 自动执行注册表中的 AutoRun (例如 chcp 65001)
  -- 避免外部格式化工具 (如 stylua/prettier) 输出被污染并注入到文件首行
  vim.opt.shellcmdflag = "/d /s /c"

  -- 确保 fnm / node.exe 在非终端环境（如资源管理器右键启动）时也能被正确识别
  local fnm_default = vim.fn.expand("~/AppData/Roaming/fnm/aliases/default")
  if vim.fn.executable("node") ~= 1 and vim.fn.isdirectory(fnm_default) == 1 then
    vim.env.PATH = fnm_default .. ";" .. vim.env.PATH
  end
end
