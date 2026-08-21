-- LazyVim's lang extras cover ts/python/ruby/scala/sql/json/yaml/tailwind, but
-- ship nothing for plain HTML/CSS. Re-add the three servers the old config had.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      html = {},
      cssls = {},
      emmet_ls = {
        filetypes = {
          "css",
          "html",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "typescriptreact",
        },
      },
    },
  },
}
