-- Promote mini.files to THE explorer. The LazyVim extra leaves snacks.explorer
-- in charge and parks mini.files on <leader>fm; snacks.explorer is disabled in
-- disabled.lua, so take over <leader>e / <leader>E too.
return {
  "nvim-mini/mini.files",
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Explorer (Directory of Current File)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Explorer (cwd)",
    },
    {
      "<leader>fm",
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Explorer (Root Dir)",
    },
  },
  opts = {
    mappings = {
      go_in = "<Right>",
      go_out = "<Left>",
    },
    windows = {
      width_nofocus = 20,
      width_focus = 50,
      width_preview = 100,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
}
