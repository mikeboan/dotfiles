-- LazyVim covers day-to-day git with lazygit (<leader>gg), gitsigns hunks
-- (<leader>gh), and snacks.gitbrowse (<leader>gY). Diffview stays for the two
-- things those don't do: 3-way merge resolution (wired up as git's mergetool in
-- ~/.gitconfig) and branch-wide file history.
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (file)" },
    },
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed", -- LOCAL | REMOTE on top, MERGED below
          disable_diagnostics = true,
        },
      },
    },
  },
}
