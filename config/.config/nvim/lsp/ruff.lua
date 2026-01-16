-- Ruff LSP (Python linting/formatting)
-- Fast Rust-based linter, replaces flake8/black/isort
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', 'setup.py', '.git' },
  settings = {
    args = {},
  },
}
