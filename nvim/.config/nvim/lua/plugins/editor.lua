return {
  -- Detect indent settings from the file/project (LazyVim only reads .editorconfig)
  { "tpope/vim-sleuth", event = "LazyFile" },

  -- Undo history as a navigable tree
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },

  -- Open files from a nested shell in the OUTER nvim instead of nesting a new
  -- one. Also makes `git commit` from a terminal split reuse this instance.
  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001, -- must load before anything that opens buffers
    opts = {
      window = { open = "alternate" },
    },
  },
}
