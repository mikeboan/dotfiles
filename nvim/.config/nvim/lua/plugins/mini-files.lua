-- Promote mini.files to the primary explorer. The LazyVim extra leaves
-- snacks.explorer on <leader>e and parks mini.files on <leader>fm; take over
-- <leader>e / <leader>E. snacks.explorer lives on `-` (see explorer.lua).
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
  init = function()
    -- `-` = parent dir, as in oil and the snacks tree (see explorer.lua)
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "-", function()
          require("mini.files").go_out()
        end, { buffer = args.data.buf_id, desc = "Go out of directory" })
      end,
    })
  end,
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
