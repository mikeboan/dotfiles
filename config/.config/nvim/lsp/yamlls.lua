-- YAML Language Server
-- Uses schemastore for schema validation
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  settings = {
    yaml = {
      validate = true,
      format = { enable = true },
      hover = true,
      completion = true,
      -- Note: schemas are configured in language-support.lua after schemastore loads
    },
  },
}
