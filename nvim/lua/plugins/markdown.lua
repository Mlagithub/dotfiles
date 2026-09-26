return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      -- 让 MarkdownPreview 相关命令在全局所有 buffer 中均可用
      vim.g.mkdp_command_for_global = 1
      -- 在命令行打印预览页面的 URL，方便调试和点击
      vim.g.mkdp_echo_preview_url = 1
      -- 切换到非 markdown 缓冲区时自动关闭预览
      vim.g.mkdp_auto_close = 1

      -- 命令行别名/缩写：支持小写的 markdownpreviewtoggle / markdownpreview / markdownpreviewstop
      vim.cmd([[
        cnoreabbrev <expr> markdownpreviewtoggle (getcmdtype() == ':' && getcmdpos() <= 22) ? 'MarkdownPreviewToggle' : 'markdownpreviewtoggle'
        cnoreabbrev <expr> markdownpreview (getcmdtype() == ':' && getcmdpos() <= 16) ? 'MarkdownPreview' : 'markdownpreview'
        cnoreabbrev <expr> markdownpreviewstop (getcmdtype() == ':' && getcmdpos() <= 20) ? 'MarkdownPreviewStop' : 'markdownpreviewstop'
      ]])
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])

      -- 显式注册全局命令，确保即使在未关联 markdown 的 buffer 中也能随时调用
      vim.api.nvim_create_user_command("MarkdownPreviewToggle", function()
        vim.fn["mkdp#util#toggle_preview"]()
      end, { desc = "Toggle Markdown Preview" })

      vim.api.nvim_create_user_command("MarkdownPreview", function()
        vim.fn["mkdp#util#open_preview_page"]()
      end, { desc = "Open Markdown Preview" })

      vim.api.nvim_create_user_command("MarkdownPreviewStop", function()
        vim.fn["mkdp#util#stop_preview"]()
      end, { desc = "Stop Markdown Preview" })
    end,
  },
}
