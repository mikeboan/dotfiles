return {
  -- Seamless <C-hjkl> movement across tmux panes and nvim splits
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Go to Left Window" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Go to Lower Window" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Go to Upper Window" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Go to Right Window" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Go to Previous Window" },
    },
  },
}
