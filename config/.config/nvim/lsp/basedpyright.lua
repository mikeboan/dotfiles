-- Python LSP (basedpyright)
-- Faster and more actively maintained than pyright
-- Per-project config via .nvim.lua or pyrightconfig.json
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', 'manage.py', '.git' },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'basic',
        autoImportCompletions = true,
      },
    },
  },
}
