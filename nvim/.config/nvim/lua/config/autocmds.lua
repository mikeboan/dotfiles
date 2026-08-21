-- Loaded on VeryLazy, after LazyVim's own autocmds:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local augroup = function(name)
  return vim.api.nvim_create_augroup("mike_" .. name, { clear = true })
end

local function is_safe_to_checktime()
  -- checktime errors when called from the command-line window (q:)
  return vim.fn.getcmdwintype() == ""
end

-- ---------------------------------------------------------------------------
-- Reload buffers changed on disk (code agents, git checkout, another editor).
-- LazyVim already checktimes on FocusGained/TermClose/TermLeave; these cover
-- buffer switches, idle-in-buffer, and the "watching an agent work" case.
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup("auto_reload"),
  callback = function()
    if is_safe_to_checktime() then
      vim.cmd("checktime")
    end
  end,
})

-- CursorHold only fires once until the cursor moves, so poll for the fully
-- idle case. checktime is just stat() on loaded buffers — negligible cost.
-- (A timer, not libuv file watchers: macOS kqueue breaks on the
-- delete-then-recreate write pattern most tools use.)
local RELOAD_POLL_MS = 1000
local reload_timer = vim.uv.new_timer()
reload_timer:start(
  RELOAD_POLL_MS,
  RELOAD_POLL_MS,
  vim.schedule_wrap(function()
    if is_safe_to_checktime() then
      vim.cmd("checktime")
    end
  end)
)

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup("auto_reload_notify"),
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})

-- ---------------------------------------------------------------------------
-- Autosave. Deliberately NOT on BufLeave: that fires when moving between
-- splits, which triggers format-on-save and makes code jump while you look at
-- it. InsertLeave only fires on leaving insert mode.
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "FocusLost", "InsertLeave" }, {
  group = augroup("auto_save"),
  callback = function(event)
    local buf = event.buf
    local is_real_file = vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= ""
    if vim.bo[buf].modified and is_real_file then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent! write")
      end)
    end
  end,
})

-- ---------------------------------------------------------------------------
-- Dim the background when the tmux pane loses focus, matching tmux's inactive
-- pane color. Needs `set -g focus-events on` in tmux.conf.
-- Only dims Normal; groups with their own bg (NormalFloat, SignColumn) stay put.
-- ---------------------------------------------------------------------------
local DIM_BG = "#292e42"
local focus_dim = augroup("focus_dim")

vim.api.nvim_create_autocmd("FocusLost", {
  group = focus_dim,
  callback = function()
    vim.g._saved_normal_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
    vim.api.nvim_set_hl(0, "Normal", { bg = DIM_BG })
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = focus_dim,
  callback = function()
    if vim.g._saved_normal_bg and vim.g._saved_normal_bg ~= "" then
      vim.api.nvim_set_hl(0, "Normal", { bg = vim.g._saved_normal_bg })
    else
      vim.cmd.colorscheme(vim.g.colors_name)
    end
  end,
})
