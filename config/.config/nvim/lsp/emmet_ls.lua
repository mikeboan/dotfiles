-- Emmet Language Server
-- HTML/CSS expansion
return {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'htmldjango' },
  root_markers = { '.git' },
}
