-- Angular Language Server
-- Supports:
--   1. Project-local @angular/language-server (if installed)
--   2. Version-matched server from ~/.local/share/angular-language-servers/{major}/
--   3. Mason-installed ngserver (requires TypeScript 5.0+)

local function get_angular_version(node_modules)
  local pkg = node_modules .. '/@angular/core/package.json'
  local f = io.open(pkg, 'r')
  if f then
    local content = f:read('*a')
    f:close()
    local version = content:match('"version"%s*:%s*"(%d+)')
    return version
  end
  return nil
end

local function get_ts_major_version(node_modules)
  local pkg = node_modules .. '/typescript/package.json'
  local f = io.open(pkg, 'r')
  if f then
    local content = f:read('*a')
    f:close()
    local version = content:match('"version"%s*:%s*"(%d+)')
    return tonumber(version)
  end
  return nil
end

return {
  cmd = { 'ngserver', '--stdio' },
  filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
  root_markers = { 'angular.json' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local angular_json = vim.fs.find('angular.json', { upward = true, path = fname })[1]

    if not angular_json then
      return
    end

    local dir = vim.fn.fnamemodify(angular_json, ':h')
    local node_modules = dir .. '/node_modules'

    -- Option 1: Project-local @angular/language-server
    local local_ngserver = node_modules .. '/@angular/language-server/bin/ngserver'
    if vim.fn.filereadable(local_ngserver) == 1 then
      vim.lsp.config('angularls', {
        cmd = {
          local_ngserver, '--stdio',
          '--tsProbeLocations', node_modules,
          '--ngProbeLocations', node_modules,
        },
      })
      on_dir(dir)
      return
    end

    -- Option 2: Version-matched from ~/.local/share/angular-language-servers/
    local angular_major = get_angular_version(node_modules)
    if angular_major then
      local cache_dir = vim.fn.expand('~/.local/share/angular-language-servers/' .. angular_major)
      local cached_ngserver = cache_dir .. '/node_modules/@angular/language-server/bin/ngserver'
      if vim.fn.filereadable(cached_ngserver) == 1 then
        vim.lsp.config('angularls', {
          cmd = {
            cached_ngserver, '--stdio',
            '--tsProbeLocations', node_modules,
            '--ngProbeLocations', node_modules,
          },
        })
        on_dir(dir)
        return
      end
    end

    -- Option 3: Mason ngserver (requires TS 5.0+)
    local ts_major = get_ts_major_version(node_modules)
    if ts_major and ts_major >= 5 then
      vim.lsp.config('angularls', {
        cmd = {
          'ngserver', '--stdio',
          '--tsProbeLocations', node_modules,
          '--ngProbeLocations', node_modules,
        },
      })
      on_dir(dir)
      return
    end

    -- No compatible server found
    vim.notify(
      string.format(
        'Angular LS: No compatible server for Angular %s / TS %s.\n' ..
        'Run: mkdir -p ~/.local/share/angular-language-servers/%s && ' ..
        'cd ~/.local/share/angular-language-servers/%s && npm init -y && npm i @angular/language-server@%s',
        angular_major or '?', ts_major or '?',
        angular_major or 'X', angular_major or 'X', angular_major or 'X'
      ),
      vim.log.levels.WARN
    )
  end,
}
