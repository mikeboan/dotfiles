-- snacks.explorer as a sidebar tree on `-` (oil's key), revealing the current
-- file. mini.files keeps <leader>e / <leader>E (see mini-files.lua) and the
-- directory-buffer hijack (`nvim .`), so snacks must not replace netrw too.
--
-- Tree keys mirror mini.files where an equivalent exists; vim verbs mean what
-- they mean in a buffer (dd, yy, x, p, o, cc). Rationale + full matrix:
-- .claude/research/file-explorer-keymaps.md

-- Paths marked by `x`. Pasting moves them, then clears; `yy` clears too.
local cut = {} ---@type string[]

local function tree_update(picker, target)
  require("snacks.explorer.actions").update(picker, { target = target, refresh = true })
end

-- Visual-mode actions operate on the visual range.
local function select_visual(picker)
  if vim.fn.mode():find("^[vV]") then
    picker.list:select()
  end
end

local function selected_paths(picker)
  local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected({ fallback = true }))
  picker.list:set_selected()
  return paths
end

local function has_unsaved_buffer(path)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if vim.bo[buf].modified and (name == path or vim.startswith(name, path .. "/")) then
      return true
    end
  end
  return false
end

-- Why a destination is unsafe, or nil. Snacks' copy/rename overwrite silently
-- and a move drops unsaved edits in open buffers, so refuse rather than lose data.
local function paste_conflict(from, to, is_move)
  if not vim.uv.fs_stat(from) then
    return "source no longer exists"
  elseif vim.uv.fs_stat(to) then
    return "destination exists"
  elseif vim.startswith(to, from .. "/") then
    return "can't paste a directory into itself"
  elseif is_move and has_unsaved_buffer(from) then
    return "has unsaved changes"
  end
end

local function paste(picker)
  local is_move = #cut > 0
  local sources = is_move and cut
    or vim.tbl_filter(function(file)
      return file ~= "" and vim.uv.fs_stat(file) ~= nil
    end, vim.split(vim.fn.getreg(vim.v.register), "\n", { plain = true }))
  if #sources == 0 then
    return Snacks.notify.warn("Nothing to paste: `yy` or `x` some files first")
  end

  local Tree = require("snacks.explorer.tree")
  local dir = picker:dir()
  local skipped = {} ---@type string[]
  for _, from in ipairs(sources) do
    local to = dir .. "/" .. vim.fs.basename(from)
    local conflict = paste_conflict(from, to, is_move)
    if conflict then
      table.insert(skipped, ("- `%s`: %s"):format(vim.fn.fnamemodify(from, ":~:."), conflict))
    elseif is_move then
      Snacks.rename.rename_file({ from = from, to = to })
      Tree:refresh(vim.fs.dirname(from))
    else
      Snacks.picker.util.copy_path(from, to)
    end
  end
  if #skipped > 0 then
    Snacks.notify.warn("Skipped:\n" .. table.concat(skipped, "\n"))
  end
  cut = {}
  Tree:refresh(dir)
  Tree:open(dir)
  tree_update(picker, dir)
end

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    {
      "-",
      function()
        Snacks.explorer.reveal():focus()
      end,
      desc = "Explorer Tree (Reveal File)",
    },
  },
  opts = {
    explorer = { replace_netrw = false },
    picker = {
      sources = {
        explorer = {
          -- reveal can't land inside a hidden dir (e.g. this repo's .config/)
          hidden = true,
          actions = {
            mike_delete = function(picker)
              select_visual(picker)
              picker:action("explorer_del")
            end,
            mike_yank = function(picker)
              cut = {}
              picker:action("explorer_yank")
            end,
            mike_cut = function(picker)
              select_visual(picker)
              cut = selected_paths(picker)
              Snacks.notify.info(("Cut %d file(s); `p` in the destination to move"):format(#cut))
            end,
            mike_paste = paste,
            -- mini.files' go_in_plus: open the file and get out of the way
            mike_open_close = function(picker, item)
              if item and not item.dir then
                picker:action("jump")
                picker:close()
              else
                picker:action("confirm")
              end
            end,
            mike_root_to_project = function(picker)
              local buf = vim.api.nvim_win_get_buf(picker.main)
              picker:set_cwd(LazyVim.root({ buf = buf }))
              picker:find()
            end,
          },
          win = {
            list = {
              keys = {
                -- navigation: <Right>/<Left> as in mini.files; h/l kept
                ["<Right>"] = "confirm",
                ["<Left>"] = "explorer_close",
                ["L"] = "mike_open_close",
                -- root: `-` up (oil), `.` into dir under cursor, `` ` `` project root
                ["-"] = "explorer_up",
                ["`"] = "mike_root_to_project",
                -- file ops as vim verbs
                ["o"] = "explorer_add",
                ["O"] = "explorer_add",
                ["cc"] = "explorer_rename",
                ["cw"] = "explorer_rename",
                ["dd"] = "mike_delete",
                ["d"] = { "mike_delete", mode = { "x" } },
                ["yy"] = "mike_yank",
                ["y"] = { "mike_yank", mode = { "x" } },
                ["x"] = { "mike_cut", mode = { "n", "x" } },
                ["p"] = "mike_paste",
                -- g-prefixed toggles/utilities, matching mini.files where it has them
                ["g."] = "toggle_hidden",
                ["gi"] = "toggle_ignored",
                ["gc"] = "tcd",
                ["gx"] = "explorer_open",
                ["g?"] = "toggle_help_list",
                ["="] = "explorer_update",
                -- splits: mini.files' <C-w>s/v; snacks' <c-s>/<c-v> still work
                ["<C-w>s"] = "edit_split",
                ["<C-w>v"] = "edit_vsplit",
                -- defaults that shadow vim meanings
                ["a"] = false,
                ["c"] = false,
                ["m"] = false,
                ["r"] = false,
                ["u"] = false,
                ["H"] = false,
                ["I"] = false,
                ["<c-c>"] = false,
              },
            },
          },
        },
      },
    },
  },
}
