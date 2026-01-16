-- JSON Language Server
-- Uses schemastore for schema validation
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git' },
  init_options = {
    provideFormatter = true,
  },
  -- Note: schemas are configured in language-support.lua after schemastore loads
}
