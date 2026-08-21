-- LazyVim ships blink.cmp with the `enter` preset. Swap to `super-tab` so <Tab>
-- accepts, and add back the vim-native accept/cancel keys.
--
-- Resulting insert-mode map:
--   <Tab>      accept (or jump snippet / accept AI suggestion)
--   <CR>       accept
--   <C-y>      accept
--   <C-e>      cancel
--   <C-n>/<C-p>  next/prev item
--   <C-b>/<C-f>  scroll docs
--   <C-space>  show menu / toggle docs
--   <C-k>      signature help
--
-- <Tab> is intentionally left unset here: LazyVim's config() wraps the
-- super-tab preset's <Tab> with snippet_forward + ai_accept for us.
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-y>"] = { "select_and_accept", "fallback" },
    },
  },
}
