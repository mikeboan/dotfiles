return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      -- Default diff bgs blend at 25% (teal for adds), which washes out syntax
      -- colors -- comments especially. Quieter tints keep the text readable;
      -- set in on_colors so gitsigns/diffview/etc. inherit the same palette.
      on_colors = function(c)
        local blend = require("tokyonight.util").blend_bg
        c.diff = {
          add = blend(c.green, 0.12),
          delete = blend(c.red1, 0.12),
          change = blend(c.blue7, 0.18),
          text = blend(c.blue, 0.18), -- changed chars within a changed line
        }
      end,
      on_highlights = function(hl, c)
        local blend = require("tokyonight.util").blend_bg
        -- Added chars within a changed line (nvim 0.12; links to DiffText by default)
        hl.DiffTextAdd = { bg = blend(c.green, 0.2) }
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight-storm" } },
}
