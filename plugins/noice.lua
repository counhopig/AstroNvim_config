return {
  "folke/noice.nvim",
  config = function()
    require("noice").setup {
      preset = {
        command_palette = false,
      },
    }
  end,
}
