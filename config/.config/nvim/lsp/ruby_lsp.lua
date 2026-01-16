-- Ruby Language Server
-- Modern Ruby LSP (faster than Solargraph)
return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'auto',
    linters = { 'rubocop' },
  },
}
