return {
  -- Noice replaces the cmdline/messages/popupmenu UI. Prefer the native ones.
  -- lualine's noice components are cond-guarded on package.loaded, so they
  -- simply drop out. snacks.notifier still handles LSP progress + vim.notify.
  { "folke/noice.nvim", enabled = false },
}
