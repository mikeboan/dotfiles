# Git Workflow Guide

**Last Updated**: November 8, 2025

---

## Overview

This guide covers local Git operations in Neovim using Neogit (Magit-inspired UI), gitsigns (inline change indicators), git-conflict (conflict resolution), and diffview (enhanced diffs). For GitHub PR/issue management, see `GITHUB_PR_WORKFLOW.md`.

---

## Implementation

### Plugins
- **gitsigns.nvim**: Inline git blame, hunk operations, change indicators
- **neogit**: Full-featured Git UI (staging, committing, pushing, rebasing)
- **git-conflict.nvim**: Merge conflict resolution with visual markers
- **diffview.nvim**: Split view diffs and file history

### Configuration File
- **Location**: `lua/mike-custom/config/git.lua`

### Prerequisites
- Git installed and configured
- GitHub CLI (`gh`) for Octo integration (separate workflow)

---

## Keybinding Reference

### Change Navigation (gitsigns)

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `]c` | Next change | Jump to next git hunk |
| `[c` | Previous change | Jump to previous git hunk |

### Hunk Operations (gitsigns)

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>hs` | Normal/Visual | Stage hunk | Stage current/selected hunk |
| `<leader>hr` | Normal/Visual | Reset hunk | Discard current/selected hunk |
| `<leader>hS` | Normal | Stage buffer | Stage entire file |
| `<leader>hR` | Normal | Reset buffer | Discard all changes in file |
| `<leader>hp` | Normal | Preview hunk | Show hunk diff in float |
| `<leader>hb` | Normal | Blame line | Show git blame for line |
| `<leader>hd` | Normal | Diff index | Diff against index |
| `<leader>hD` | Normal | Diff HEAD | Diff against last commit |

### Toggles (gitsigns)

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>tb` | Toggle blame | Show/hide inline blame |
| `<leader>tD` | Toggle deleted | Show/hide deleted lines |

### Git UI (Neogit)

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>gg` | Open Neogit | Launch full-screen Git UI |
| `<leader>gc` | Open in split | Launch Neogit in split |

### Conflict Resolution (git-conflict)

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `]x` | Next conflict | Jump to next conflict |
| `[x` | Previous conflict | Jump to previous conflict |
| `<leader>co` | Choose ours | Accept current branch changes |
| `<leader>ct` | Choose theirs | Accept incoming branch changes |
| `<leader>cb` | Choose both | Keep both changes |
| `<leader>c0` | Choose none | Delete both changes |

---

## Step-by-Step Workflows

### 1. Viewing Changes in Sign Column

**Scenario**: You've edited files and want to see what changed.

**Steps**:

1. **Sign column indicators** appear automatically:
   ```
   | 123  function getUserData() {
   ~ 124    const user = getCurrentUser();  // Modified line
   + 125    console.log('Debug:', user);     // Added line
   _ 126                                      // Deleted line shown below
   ```

2. **Color coding**:
   - Green bar (`+`): Added lines
   - Blue bar (`~`): Modified lines
   - Red bar (`_`): Deleted lines

3. **Navigate between changes**:
   ```
   Press: ]c    # Jump to next change
   Press: [c    # Jump to previous change
   ```

4. **Preview specific hunk**:
   ```
   Position cursor on changed line
   Press: <leader>hp
   ```

5. **Float window shows diff**:
   ```diff
   @@ -122,3 +122,4 @@
    function getUserData() {
   -  const user = getUser();
   +  const user = getCurrentUser();
   +  console.log('Debug:', user);
   ```

---

### 2. Staging Hunks (Partial Staging)

**Scenario**: You have multiple changes but only want to stage some.

**Steps**:

1. **Navigate to hunk**: `]c` / `[c`

2. **Preview the change**: `<leader>hp`

3. **Stage single hunk**:
   ```
   Press: <leader>hs
   ```

4. **Confirmation**: Sign column indicator changes to show staged

5. **Stage specific lines** (visual mode):
   ```
   Press: V           # Enter visual line mode
   Select lines: j/k
   Press: <leader>hs  # Stage only selected lines
   ```

6. **Verify staged changes**:
   ```
   Press: <leader>gg  # Open Neogit
   View staged section
   ```

---

### 3. Committing Changes with Neogit

**Scenario**: You've staged changes and are ready to commit.

**Steps**:

1. **Open Neogit**:
   ```
   Press: <leader>gg
   ```

2. **Neogit UI shows**:
   ```
   Untracked files (1)
   Unstaged changes (3)
   Staged changes (2)
   Recent commits (5)
   ```

3. **Navigate sections**:
   ```
   j/k        Move down/up
   <Tab>      Expand/collapse section
   <Enter>    Toggle stage/unstage file
   ```

4. **Stage a file**:
   ```
   Navigate to file under "Unstaged changes"
   Press: <Enter>  # Moves to "Staged changes"
   ```

5. **Stage all**:
   ```
   Press: S  # Stage all unstaged changes
   ```

6. **Start commit**:
   ```
   Press: c   # Opens commit menu
   Press: c   # Confirm commit
   ```

7. **Commit buffer opens**:
   ```markdown
   # Write commit message

   <type commit message here>

   # Lines starting with # are ignored
   # Changes to be committed:
   #   modified: src/components/UserList.tsx
   #   added: src/utils/helpers.ts
   ```

8. **Write message**:
   ```
   Add user debugging helpers

   - Add getUserData helper function
   - Add debug logging for user fetch
   ```

9. **Complete commit**:
   ```
   Save and close: :wq
   or: <leader>w then :q
   ```

10. **Commit created!** Neogit updates to show new commit.

---

### 4. Pushing and Pulling

**In Neogit**:

1. **Open Neogit**: `<leader>gg`

2. **Push**:
   ```
   Press: P    # Opens push menu
   Press: p    # Push to origin
   or: P u     # Push and set upstream
   ```

3. **Pull**:
   ```
   Press: F    # Opens pull menu
   Press: p    # Pull from origin
   or: F u     # Pull and rebase
   ```

4. **Fetch**:
   ```
   Press: f    # Opens fetch menu
   Press: f    # Fetch from origin
   ```

**Quick status check**:
```
In Neogit, top shows:
Head: main
Push: origin/main (ahead 2, behind 0)
```

---

### 5. Viewing Git Blame

**Scenario**: You want to see who wrote a specific line.

**Method 1: Inline Blame**

1. **Toggle inline blame**:
   ```
   Press: <leader>tb
   ```

2. **Blame appears** at end of every line:
   ```typescript
   function getUserData() {           // John Doe, 2 hours ago • feat: add user helpers
     const user = getCurrentUser();   // John Doe, 2 hours ago • feat: add user helpers
     console.log('Debug:', user);     // You, 5 minutes ago • debug: add logging
   ```

3. **Toggle off**:
   ```
   Press: <leader>tb
   ```

**Method 2: Blame Popup**

1. **Position cursor** on line

2. **Show blame popup**:
   ```
   Press: <leader>hb
   ```

3. **Popup shows**:
   ```
   a3f2e1c - John Doe, 2 hours ago
   feat: add user helpers

   This adds helper functions for user data retrieval
   and improves error handling.
   ```

---

### 6. Viewing Diffs

**Method 1: Hunk Preview (Quick)**

```
Cursor on changed line
Press: <leader>hp
```

**Method 2: File Diff Against Index**

```
Press: <leader>hd
```

Opens split view showing:
- Left: Index version
- Right: Working directory version

**Method 3: File Diff Against Last Commit**

```
Press: <leader>hD
```

**Method 4: Full Diff with Diffview**

1. **Open diffview**:
   ```
   :DiffviewOpen
   ```

2. **Shows all changed files** in sidebar

3. **Navigate files**:
   ```
   j/k        Next/previous file
   <Enter>    Open diff for file
   ```

4. **Close diffview**:
   ```
   :DiffviewClose
   or: :q in diffview buffer
   ```

---

### 7. Viewing Git History

**View file history**:

1. **Open file history**:
   ```
   :DiffviewFileHistory
   or for current file:
   :DiffviewFileHistory %
   ```

2. **History panel shows**:
   ```
   * a3f2e1c - (2 hours ago) feat: add user helpers
   * b7d9a2f - (1 day ago) refactor: extract user logic
   * c4e8b3a - (3 days ago) initial user component
   ```

3. **Navigate commits**:
   ```
   j/k        Next/previous commit
   <Enter>    View commit diff
   ```

4. **View specific commit**:
   - Select commit
   - Press `<Enter>`
   - Diff view opens

**View line history**:

1. **Visual select lines**
2. **Run**: `:DiffviewFileHistory`
3. **Shows commits** affecting only those lines

---

### 8. Branching in Neogit

**Create new branch**:

1. **Open Neogit**: `<leader>gg`

2. **Branch menu**:
   ```
   Press: b    # Opens branch menu
   Press: c    # Create new branch
   ```

3. **Enter branch name**:
   ```
   Branch name: feature/user-improvements
   ```

4. **Branch created and checked out**

**Switch branches**:

```
Press: b    # Branch menu
Press: b    # Checkout branch
Select from list or type name
```

**Delete branch**:

```
Press: b    # Branch menu
Press: D    # Delete branch
Select branch to delete
```

---

### 9. Resolving Merge Conflicts

**Scenario**: You have merge conflicts after pulling or merging.

**Steps**:

1. **Conflict markers appear** in file:
   ```javascript
   function getUser() {
   <<<<<<< HEAD (Current Change)
     return getCurrentUser();
   =======
     return fetchUser();
   >>>>>>> feature-branch (Incoming Change)
   }
   ```

2. **git-conflict highlights** the sections:
   - Blue: Current changes (ours)
   - Green: Incoming changes (theirs)
   - Gray: Conflict markers

3. **Navigate conflicts**:
   ```
   Press: ]x    # Next conflict
   Press: [x    # Previous conflict
   ```

4. **Choose resolution**:
   ```
   <leader>co   # Keep ours (getCurrentUser)
   <leader>ct   # Keep theirs (fetchUser)
   <leader>cb   # Keep both (stacked)
   <leader>c0   # Delete both (manual edit)
   ```

5. **Manual editing** (if needed):
   - Choose `<leader>c0`
   - Edit as desired
   - Remove conflict markers manually

6. **Stage resolved file**:
   ```
   Press: <leader>hS  # Stage buffer
   or in Neogit: <leader>gg, then <Enter> on file
   ```

7. **Complete merge**:
   ```
   In Neogit:
   Press: c c  # Commit merge
   ```

---

### 10. Stashing Changes

**In Neogit**:

1. **Open Neogit**: `<leader>gg`

2. **Stash menu**:
   ```
   Press: Z    # Opens stash menu
   Press: z    # Stash working directory
   ```

3. **Enter stash message**:
   ```
   Stash message: WIP: user improvements
   ```

4. **List stashes**:
   ```
   In Neogit, scroll to "Stashes" section
   or: Z l
   ```

5. **Apply stash**:
   ```
   Navigate to stash
   Press: a    # Apply
   or: p       # Pop (apply and delete)
   ```

6. **Drop stash**:
   ```
   Navigate to stash
   Press: k    # Drop stash
   ```

---

### 11. Rebasing

**Interactive rebase in Neogit**:

1. **Open Neogit**: `<leader>gg`

2. **Rebase menu**:
   ```
   Press: r    # Rebase menu
   Press: i    # Interactive rebase
   ```

3. **Select base commit** or enter: `HEAD~3`

4. **Rebase buffer opens** with commits:
   ```
   pick a3f2e1c feat: add user helpers
   pick b7d9a2f refactor: extract logic
   pick c4e8b3a fix typo
   ```

5. **Edit as needed**:
   ```
   Change "pick" to:
   r/reword   - Edit commit message
   e/edit     - Edit commit content
   s/squash   - Combine with previous
   f/fixup    - Squash without message
   d/drop     - Remove commit
   ```

6. **Save and close**: `:wq`

7. **Rebase executes** with your changes

**Abort rebase**:
```
In Neogit:
Press: r a  # Abort rebase
```

---

## Neogit Keybindings Reference

**When Neogit is open (`<leader>gg`)**:

### File Operations
| Key | Action |
|-----|--------|
| `<Enter>` | Stage/unstage file/hunk |
| `s` | Stage file |
| `u` | Unstage file |
| `S` | Stage all |
| `U` | Unstage all |
| `x` | Discard changes |
| `=` | Toggle diff |
| `<Tab>` | Toggle section |

### Commit Operations
| Key | Action |
|-----|--------|
| `c c` | Commit |
| `c a` | Commit --amend |
| `c e` | Extend (amend without editing) |
| `c w` | Reword commit message |
| `c f` | Fixup commit |

### Branch Operations
| Key | Action |
|-----|--------|
| `b b` | Checkout branch |
| `b c` | Create new branch |
| `b r` | Rename branch |
| `b D` | Delete branch |

### Remote Operations
| Key | Action |
|-----|--------|
| `F p` | Pull |
| `F u` | Pull with rebase |
| `P p` | Push |
| `P u` | Push and set upstream |
| `P f` | Force push (dangerous!) |
| `f f` | Fetch |

### Rebase Operations
| Key | Action |
|-----|--------|
| `r i` | Interactive rebase |
| `r e` | Rebase elsewhere |
| `r a` | Abort rebase |
| `r c` | Continue rebase |

### Stash Operations
| Key | Action |
|-----|--------|
| `Z z` | Stash working directory |
| `Z i` | Stash with message |
| `Z a` | Apply stash |
| `Z p` | Pop stash |
| `Z k` | Drop stash |

### Log & Diff
| Key | Action |
|-----|--------|
| `l l` | Show log |
| `l o` | Show log for file |
| `d d` | Show diff |
| `d r` | Diff range |

### Other
| Key | Action |
|-----|--------|
| `$` | Show git command output |
| `q` | Close Neogit |
| `?` | Show help |
| `g?` | Show dispatch help |

---

## Common Workflows

### Workflow 1: Feature Development Cycle

1. **Create feature branch**
   ```
   <leader>gg → b c → "feature/my-feature"
   ```

2. **Write code, see changes in sign column**
   - Green/blue/red indicators appear
   - Navigate with `]c` / `[c`

3. **Preview changes before staging**
   ```
   <leader>hp on each hunk
   ```

4. **Stage changes incrementally**
   ```
   <leader>hs on good hunks
   <leader>hr to discard bad hunks
   ```

5. **Commit with descriptive message**
   ```
   <leader>gg → c c → write message → :wq
   ```

6. **Push to remote**
   ```
   <leader>gg → P u  # First push with upstream
   Later: P p        # Subsequent pushes
   ```

7. **Create PR** (see GITHUB_PR_WORKFLOW.md)
   ```
   <leader>gpc
   ```

---

### Workflow 2: Fixing Conflicts After Pull

1. **Pull latest changes**
   ```
   <leader>gg → F p
   ```

2. **Conflict detected** - file opens with markers

3. **Navigate conflicts**
   ```
   ]x to jump to each conflict
   ```

4. **For each conflict, choose**:
   - `<leader>co` for current changes
   - `<leader>ct` for incoming changes
   - `<leader>cb` for both
   - `<leader>c0` for manual edit

5. **Stage resolved files**
   ```
   <leader>hS on each file
   or <leader>gg → S to stage all
   ```

6. **Complete merge**
   ```
   <leader>gg → c c → :wq
   ```

---

### Workflow 3: Interactive Rebase to Clean History

1. **View recent commits**
   ```
   <leader>gg → l l
   ```

2. **Start rebase**
   ```
   Press: r i
   Enter: HEAD~5  # Last 5 commits
   ```

3. **Edit rebase plan**:
   ```
   pick a3f2e1c feat: add feature
   fixup b7d9a2f fix typo       # Squash into previous
   reword c4e8b3a update docs   # Edit message
   pick d8f3a1b add tests
   drop e2b9c7f debug commit    # Remove entirely
   ```

4. **Save**: `:wq`

5. **For rewording**, edit message when prompted

6. **Push with force** (if already pushed):
   ```
   <leader>gg → P f  # CAUTION: Only if not shared!
   ```

---

### Workflow 4: Quick Bug Fix

1. **See problem, make fix**

2. **Stage entire file**:
   ```
   <leader>hS
   ```

3. **Quick commit**:
   ```
   <leader>gg
   c c
   "fix: resolve user null check"
   :wq
   ```

4. **Push**:
   ```
   P p
   ```

5. **Done!** Close Neogit: `q`

---

### Workflow 5: Reviewing Someone's Changes

1. **Fetch latest**:
   ```
   <leader>gg → f f
   ```

2. **Checkout their branch**:
   ```
   b b → select "origin/their-feature"
   ```

3. **View diff against main**:
   ```
   :DiffviewOpen main..HEAD
   ```

4. **Navigate files** in diffview

5. **Leave feedback** via PR review (see GITHUB_PR_WORKFLOW.md)

---

## tmux Integration

**Typical git workflow in tmux**:

```
┌─────────────────────────────────┬──────────────────┐
│                                 │                  │
│   nvim (editor)                 │  Terminal pane   │
│   - Make changes                │  - git status    │
│   - <leader>gg for Neogit       │  - git log       │
│   - Stage with <leader>hs       │  - git diff      │
│   - Commit in Neogit            │  - npm test      │
│                                 │                  │
└─────────────────────────────────┴──────────────────┘
```

**When to use terminal git vs Neogit**:

| Operation | Neogit | Terminal |
|-----------|--------|----------|
| Stage/commit | ✅ Preferred | Optional |
| Push/pull | ✅ Preferred | Optional |
| View log | ✅ Visual | `git log --oneline` |
| Rebase | ✅ Interactive | `git rebase -i` |
| Complex merges | ⚠️ Use terminal | ✅ `git merge` with options |
| Git aliases | ❌ Not available | ✅ Custom aliases work |
| Scripted operations | ❌ | ✅ Bash scripts |

---

## Comparison with IntelliJ Git UI

| Feature | IntelliJ Git | Neovim (gitsigns + Neogit) | Notes |
|---------|--------------|----------------------------|-------|
| Change indicators | ✅ | ✅ | Same sign column markers |
| Inline blame | ✅ | ✅ | `<leader>tb` toggle |
| Stage hunks | ✅ | ✅ | `<leader>hs` |
| Commit dialog | ✅ | ✅ | Neogit commit buffer |
| Visual diff | ✅ | ✅ | diffview.nvim |
| Conflict resolution | ✅ | ✅ | git-conflict.nvim |
| Branch switching | ✅ | ✅ | Neogit branch menu |
| Interactive rebase | ✅ | ✅ | Neogit rebase menu |
| Stash management | ✅ | ✅ | Neogit stash menu |
| Shelving | ✅ | ⚠️ | Use git stash |
| Partial commits | ✅ | ✅ | Stage hunks or lines |
| Commit tree graph | ✅ | ⚠️ | Use `git log --graph` |
| Local history | ✅ | ❌ | Use commits instead |
| Annotations | ✅ | ✅ | `<leader>hb` blame |

**Overall**: 90% feature parity. Neogit provides a Magit-inspired workflow that many find superior to IntelliJ's GUI.

---

## Tips & Best Practices

1. **Use sign column** for quick change overview
2. **Preview hunks** before staging (`<leader>hp`)
3. **Stage incrementally** for atomic commits
4. **Keep Neogit open** in split while working (`<leader>gc`)
5. **Learn Magit keybindings** - they're powerful
6. **Use diffview** for complex diffs
7. **Blame often** to understand code history
8. **Rebase locally** before pushing (clean history)
9. **Stash for quick context switches**
10. **Use tmux pane** for git commands Neogit doesn't cover

---

## Troubleshooting

### Sign column not showing changes

**Cause**: gitsigns not loaded or not in git repo

**Solution**:
```vim
:checkhealth gitsigns
:Gitsigns refresh
```

### Neogit not opening

**Cause**: Not in git repository

**Solution**:
```bash
cd /path/to/git/repo
nvim
```

### Merge conflicts not highlighting

**Cause**: git-conflict.nvim not loaded

**Solution**:
```vim
:checkhealth git-conflict
# Check if file has conflict markers
```

### Diffview slow on large repos

**Cause**: Large file count

**Solution**:
```vim
" Limit to current file
:DiffviewFileHistory %

" Or use git diff in terminal
```

---

## Quick Reference Card

```
GIT OPERATIONS

Change Navigation:
  ]c              Next change (hunk)
  [c              Previous change

Hunk Operations (<leader>h prefix):
  <leader>hs      Stage hunk (n/v)
  <leader>hr      Reset hunk (n/v)
  <leader>hS      Stage entire buffer
  <leader>hR      Reset entire buffer
  <leader>hp      Preview hunk diff
  <leader>hb      Blame line
  <leader>hd      Diff against index
  <leader>hD      Diff against HEAD

Git UI:
  <leader>gg      Open Neogit
  <leader>gc      Open Neogit in split

Conflict Resolution:
  ]x / [x         Next/previous conflict
  <leader>co      Choose ours
  <leader>ct      Choose theirs
  <leader>cb      Choose both
  <leader>c0      Choose none

Toggles:
  <leader>tb      Toggle inline blame
  <leader>tD      Toggle show deleted

In Neogit:
  <Enter>         Stage/unstage
  c c             Commit
  P p             Push
  F p             Pull
  b b             Switch branch
  b c             Create branch
  r i             Interactive rebase
  Z z             Stash
  l l             Show log
  ?               Help
  q               Quit
```

---

## Related Workflows

- **GitHub PRs**: See `GITHUB_PR_WORKFLOW.md` for Octo.nvim
- **Testing**: Run tests before committing (`<leader>a`)
- **Refactoring**: Use `<leader>R*` then commit changes
- **Code Review**: Combine diffview + Octo for reviews

---

## Further Reading

- Neogit: `:help neogit`
- gitsigns: `:help gitsigns`
- Diffview: `:help diffview`
- Magit tutorial: https://magit.vc/manual/
- Config: `lua/mike-custom/config/git.lua`

---

**Next**: Try the feature development workflow with Neogit!
