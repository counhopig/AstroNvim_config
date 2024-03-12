return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.statusline = { -- 状态栏
      hl = { fg = "fg", bg = "bg" },
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- 添加模式文本
      status.component.git_branch(),
      status.component.file_info { filetype = {}, filename = false, file_modified = false },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.nav(),
      -- 移除右侧的第二个模式指示器
    }

    opts.winbar = { -- 创建自定义的窗口栏
      -- 存储当前缓冲区编号
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false, -- 根据条件选择正确的窗口栏
      -- 非活动窗口栏
      {
        condition = function() return not status.condition.is_active() end,
        -- 显示相对于工作目录的文件路径
        status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
        -- 添加文件名和图标
        status.component.file_info {
          file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        },
      },
      -- 活动窗口栏
      {
        -- 显示相对于工作目录的文件路径
        status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
        -- 添加文件名和图标
        status.component.file_info { -- 添加文件信息到breadcrumbs
          file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbar", true),
          surround = false,
          update = "BufEnter",
        },
        -- 显示breadcrumbs
        status.component.breadcrumbs {
          icon = { hl = true },
          hl = status.hl.get_attributes("winbar", true),
          prefix = true,
          padding = { left = 0 },
        },
      },
    }
    -- 返回最终的配置表
    return opts
  end,
}
