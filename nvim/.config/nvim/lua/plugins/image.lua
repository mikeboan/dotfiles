-- Inline images + mermaid diagrams in markdown via the kitty graphics protocol.
-- Mermaid needs `mmdc` (Brewfile: mermaid-cli). Unsupported terminals just
-- show the source; :MarkdownPreview remains the fallback.
--
-- Tall diagrams are awkward inline (source and image swap as the cursor moves),
-- so <leader>cP also renders the block under the cursor in a right split that
-- re-renders on save.

local ns = vim.api.nvim_create_namespace("mermaid_split")

---@type { win?: integer, src_buf?: integer, mark?: integer }
local split = {}

--- The rendered-image source of the diagram block covering `row` (1-based).
---@param buf integer
---@param row integer
---@param cb fun(src?: string)
local function image_at(buf, row, cb)
  Snacks.image.doc.find(buf, function(imgs)
    for _, img in ipairs(imgs) do
      if img.range and row >= img.range[1] and row <= img.range[3] then
        return cb(img.src)
      end
    end
    cb()
  end, { from = row, to = row + 1 })
end

--- Show `src` in the split, opening the split if needed.
---@param src string
local function show(src)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "image"
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    callback = function()
      Snacks.image.placement.clean(buf)
    end,
  })
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, desc = "Close diagram" })

  if split.win and vim.api.nvim_win_is_valid(split.win) then
    vim.api.nvim_win_set_buf(split.win, buf)
  else
    split.win = vim.api.nvim_open_win(buf, false, { split = "right", win = 0 })
  end
  vim.bo[buf].modifiable = false
  Snacks.image.placement.new(buf, src, { conceal = true, auto_resize = true })
end

local function open_split()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  image_at(buf, row, function(src)
    if not src then
      return Snacks.notify.warn("No diagram under cursor")
    end
    -- Extmark tracks the block through edits so saves re-render the same one
    if split.src_buf and vim.api.nvim_buf_is_valid(split.src_buf) then
      vim.api.nvim_buf_clear_namespace(split.src_buf, ns, 0, -1)
    end
    split.src_buf = buf
    split.mark = vim.api.nvim_buf_set_extmark(buf, ns, row - 1, 0, {})
    show(src)
  end)
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("mermaid_split", { clear = true }),
  callback = function(ev)
    if ev.buf ~= split.src_buf or not (split.win and vim.api.nvim_win_is_valid(split.win)) then
      return
    end
    local pos = vim.api.nvim_buf_get_extmark_by_id(ev.buf, ns, split.mark, {})
    if not pos[1] then
      return
    end
    image_at(ev.buf, pos[1] + 1, function(src)
      if src then
        show(src)
      end
    end)
  end,
})

return {
  "folke/snacks.nvim",
  opts = {
    image = { enabled = true },
  },
  keys = {
    { "<leader>cP", open_split, ft = "markdown", desc = "Mermaid Diagram Split" },
  },
}
