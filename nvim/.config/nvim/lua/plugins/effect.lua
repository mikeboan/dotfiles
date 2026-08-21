-- Enable @effect/language-service (a tsserver plugin) in vtsls, and make vtsls
-- use the project's own TypeScript so the editor matches the build compiler.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              -- Use the project's local TypeScript, not vtsls's bundled one.
              autoUseWorkspaceTsdk = true,
              tsserver = {
                -- vtsls does not auto-load tsconfig `plugins` (unlike VSCode),
                -- so the Effect language-service plugin is registered here.
                globalPlugins = {
                  {
                    name = "@effect/language-service",
                    location = vim.fn.getcwd() .. "/node_modules",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
