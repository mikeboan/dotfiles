# GitHub Pull Request Workflow Guide

**Last Updated**: November 8, 2025

---

## Overview

This guide covers GitHub pull request and issue management directly from Neovim using `Octo.nvim`, providing a terminal-based alternative to IntelliJ's PR panel or the GitHub web interface.

---

## Implementation

### Plugin
- **Name**: Octo.nvim
- **Repository**: https://github.com/pwntester/octo.nvim
- **Features**: PR review, issues, comments, approvals

### Configuration File
- **Location**: `lua/mike-custom/config/git.lua` (Octo section)

### Prerequisites
- **GitHub CLI** (`gh`) installed and authenticated
  ```bash
  brew install gh
  gh auth login
  ```

### Dependencies
- Telescope (for picker UI)
- nvim-web-devicons (icons)
- plenary.nvim (utilities)

---

## Keybinding Reference

All GitHub operations use `<leader>g*` prefixes.

### Pull Request Operations

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>gpl` | List PRs | Show all PRs for repo |
| `<leader>gpc` | Create PR | Create new PR from current branch |
| `<leader>gpo` | Checkout PR | Checkout PR branch locally |
| `<leader>gpr` | Start review | Begin PR review |
| `<leader>gps` | PR checks | View CI/CD status |
| `<leader>gpm` | Merge PR | Merge the PR |

### Issue Operations

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>gil` | List issues | Show all issues |
| `<leader>gic` | Create issue | Create new issue |
| `<leader>gio` | Close issue | Close current issue |

### Review Operations

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>grs` | Review start | Start code review |
| `<leader>grc` | Review commit | Review specific commit |
| `<leader>gra` | Approve | Approve PR |
| `<leader>grr` | Request changes | Request changes on PR |

### Search

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>gss` | Search | Search issues/PRs |

---

## Step-by-Step Workflows

### 1. Listing and Browsing PRs

**Scenario**: You want to see all open PRs for your project.

**Steps**:

1. **Navigate to project** in terminal
   ```bash
   cd ~/Src/beamjobs-frontend
   ```

2. **Open Neovim** (any file or empty)
   ```bash
   nvim
   ```

3. **List PRs**
   ```
   Press: <leader>gpl
   ```

4. **Telescope picker opens** with PR list
   ```
   Use: j/k or arrow keys to navigate
   Type: to filter by title/author
   Press: <Enter> to open PR
   ```

5. **PR buffer opens** showing:
   - Title and description
   - Status (open, merged, draft)
   - CI checks
   - Reviewers
   - Comments and conversations
   - Changed files

**Example PR Buffer**:
```
#123 Fix user authentication bug

Open • john-doe wants to merge 3 commits into main from fix/auth-bug

 Checks: 2 / 2 successful
 Reviews: 1 approved, 0 changes requested
 Assignees: @jane-smith
 Labels: bug, high-priority

Description:
Fixed the authentication bug where users couldn't log in after password reset.

Changes:
- Fixed token validation
- Added tests
- Updated documentation

Files changed (3):
  src/auth/validator.ts
  src/auth/validator.spec.ts
  docs/AUTH.md
```

---

### 2. Creating a Pull Request

**Scenario**: You've pushed a feature branch and want to create a PR.

**Steps**:

1. **Ensure branch is pushed**
   ```bash
   git push -u origin feature/my-awesome-feature
   ```

2. **In Neovim**, create PR
   ```
   Press: <leader>gpc
   ```

3. **Fill in PR details** (Octo opens buffer with template)
   ```markdown
   Title: Add awesome feature

   ## Description
   This PR adds an awesome feature that...

   ## Test Plan
   - [ ] Unit tests pass
   - [ ] Manual testing completed
   - [ ] Documentation updated
   ```

4. **Submit PR**
   ```
   Press: <Ctrl-s> (in Octo buffer)
   or run: :Octo pr create
   ```

5. **PR created!** GitHub link shown in output

---

### 3. Reviewing a Pull Request

**Scenario**: Teammate asks you to review their PR.

**Steps**:

1. **List PRs** → `<leader>gpl`

2. **Select PR to review** → Press `<Enter>`

3. **Start review mode**
   ```
   Press: <leader>gpr
   or in PR buffer: <leader>ca (add comment)
   ```

4. **Navigate files**
   ```
   In PR buffer:
   gf - Go to file under cursor
   ]q - Next file
   [q - Previous file
   ```

5. **View diff** for a file
   - Cursor on filename
   - Press `gf`
   - Diff view opens

6. **Add review comments**
   ```
   Position cursor on line
   Press: <leader>ca
   Type comment in buffer
   Submit: <Ctrl-s>
   ```

7. **Add suggestions**
   ```
   Press: <leader>cs (on line)
   Type suggested code
   Submit: <Ctrl-s>
   ```

8. **Submit review**
   ```
   Press: <leader>gra (approve)
   or: <leader>grr (request changes)
   or: <Ctrl-m (comment only)
   ```

---

### 4. Checking Out a PR Locally

**Scenario**: You want to test a PR on your machine.

**Steps**:

1. **List PRs** → `<leader>gpl`

2. **Checkout PR**
   ```
   Select PR, press: <leader>gpo
   or in PR buffer: <leader>po
   ```

3. **PR branch checked out** locally
   ```
   You're now on: pr/123-branch-name
   ```

4. **Test the changes**
   ```bash
   npm install  # or bundle install, pip install, etc.
   npm test
   npm start
   ```

5. **Leave feedback** in the PR (add comments via Octo)

6. **Return to your branch**
   ```bash
   git checkout main  # or your feature branch
   ```

---

### 5. Checking CI/CD Status

**Scenario**: You want to see if PR checks passed.

**Steps**:

1. **Open PR** (via `<leader>gpl`)

2. **View checks**
   ```
   Press: <leader>gps
   or in PR buffer, checks shown at top
   ```

3. **Interpret status**
   ```
   ✓ All checks passed
   ✗ Some checks failed
   ● Checks running
   ```

4. **View failed check details**
   - Click on check name
   - Opens in browser with logs

---

### 6. Merging a Pull Request

**Scenario**: PR is approved and ready to merge.

**Steps**:

1. **Open PR** → `<leader>gpl` → Select PR

2. **Verify**:
   - ✓ All checks passed
   - ✓ Approved by reviewer(s)
   - ✓ No merge conflicts

3. **Merge PR**
   ```
   Press: <leader>gpm
   or in PR buffer: <leader>pm
   ```

4. **Choose merge method**
   ```
   - Merge commit (default)
   - Squash and merge
   - Rebase and merge
   ```

5. **Confirm merge**

6. **PR merged!** Can close the buffer

**Clean up**:
```bash
git checkout main
git pull
git branch -d feature/branch-name  # Delete local branch
```

---

### 7. Working with Issues

**List issues**:
```
Press: <leader>gil
```

**Create issue**:
```
Press: <leader>gic
Fill in title, description, labels
Submit: <Ctrl-s>
```

**Close issue**:
```
Open issue buffer
Press: <leader>gio
```

**Link PR to issue**:
```
In PR description: Fixes #123
or: Closes #456
```

---

## Advanced Features

### Threading Comments

**Add a reply to existing comment**:
1. Navigate to comment thread
2. Press: `]c` (next comment) or `[c` (prev comment)
3. Press: `<leader>ca` to reply
4. Type reply, submit with `<Ctrl-s>`

### Multi-Line Comments

**Comment on multiple lines**:
1. Enter visual mode: `V`
2. Select lines
3. Press: `<leader>ca`
4. Type comment
5. Submit: `<Ctrl-s>`

### Adding Reactions

**React to comments** (👍, 🎉, ❤️, etc):
1. Cursor on comment
2. Type: `:Octo reaction thumbs_up` (or other reaction)
3. Reaction added

### Assigning Reviewers

**Request review from teammates**:
1. In PR buffer
2. Type: `:Octo pr reviewers add @username`
3. Or use: `<leader>va` when cursor on reviewer line

### Managing Labels

**Add labels to PR/Issue**:
1. In PR/Issue buffer
2. Type: `:Octo label add bug high-priority`
3. Or use: `<leader>la` when cursor on label line

---

## Octo Buffer Keybindings

When viewing PR/Issue buffers, these mappings are available:

### Navigation
| Key | Action |
|-----|--------|
| `gf` | Go to file under cursor |
| `]c` | Next comment |
| `[c` | Previous comment |
| `]q` | Next file |
| `[q` | Previous file |

### Actions
| Key | Action |
|-----|--------|
| `<leader>ca` | Add comment |
| `<leader>cd` | Delete comment |
| `<leader>cs` | Add suggestion |
| `<leader>aa` | Add assignee |
| `<leader>ad` | Remove assignee |
| `<leader>la` | Add label |
| `<leader>ld` | Remove label |
| `<leader>va` | Add reviewer |
| `<leader>vd` | Remove reviewer |
| `<C-r>` | Reload PR/Issue |
| `<C-b>` | Open in browser |
| `<C-y>` | Copy URL |

### Review Actions
| Key | Action |
|-----|--------|
| `<leader>po` | Checkout PR |
| `<leader>pm` | Merge PR |
| `<leader>pc` | List commits |
| `<leader>pf` | List changed files |
| `<leader>pd` | Show PR diff |
| `<leader>ic` | Close PR/Issue |
| `<leader>io` | Reopen PR/Issue |

---

## Common Workflows

### Workflow 1: Daily PR Review

1. Morning: `<leader>gpl` to see PRs
2. Filter to "review requested" PRs
3. For each PR:
   - Open PR
   - Read description
   - Check CI status
   - Review code files
   - Add comments
   - Approve or request changes
4. Done!

### Workflow 2: Feature PR Creation

1. Create feature branch locally
2. Write code + tests
3. Commit changes
4. Push to GitHub
5. `<leader>gpc` to create PR
6. Fill in description with test plan
7. Request reviewers
8. Monitor CI checks
9. Address review feedback
10. Merge when approved

### Workflow 3: Bug Triage

1. `<leader>gil` list issues
2. Filter by label: "bug"
3. Read each issue
4. Reproduce locally
5. Fix the bug
6. Create PR referencing issue: "Fixes #123"
7. Issue auto-closes when PR merges

---

## Comparison with IntelliJ

| Feature | IntelliJ PR Panel | Octo.nvim | Notes |
|---------|-------------------|-----------|-------|
| List PRs | ✅ | ✅ | Similar UX |
| View diff | ✅ | ✅ | Octo uses diffview |
| Add comments | ✅ | ✅ | Text-based in Octo |
| Approve PR | ✅ | ✅ | Same workflow |
| Check CI status | ✅ | ✅ | Both show status |
| Create PR | ✅ | ✅ | Template-based |
| Merge PR | ✅ | ✅ | Same options |
| Threading | ✅ | ✅ | Navigation keys |
| Reactions | ✅ | ✅ | Via commands |
| Inline suggestions | ✅ | ✅ | `<leader>cs` |
| Draft PRs | ✅ | ✅ | Supported |
| PR templates | ✅ | ✅ | Uses GitHub templates |

**Overall**: 95% feature parity. Different UX (text vs GUI) but same capabilities.

---

## Tips & Best Practices

1. **Authenticate first**: Run `gh auth login` before using Octo
2. **Use Telescope**: `<leader>gpl` is faster than web browser
3. **Keyboard-first**: Learn buffer mappings for speed
4. **Open in browser**: Use `<C-b>` for complex discussions
5. **Draft PRs**: Create draft, iterate, then mark ready
6. **Link issues**: Always reference issue numbers in PRs
7. **CI checks**: Don't request review until CI passes
8. **Small PRs**: Easier to review (Octo or not)

---

## Troubleshooting

### "gh not authenticated"

**Solution**:
```bash
gh auth login
# Follow prompts to authenticate
```

### PR list empty

**Causes**:
- Not in a git repository
- Remote not set to GitHub
- No PRs for this repo

**Solution**:
```bash
git remote -v  # Check remote
:Octo pr list   # Try command form
```

### Can't add comments

**Cause**: Wrong permissions or not logged in.

**Solution**:
```bash
gh auth status  # Check auth
gh auth refresh  # Refresh token
```

### Diff not showing

**Cause**: diffview.nvim not installed.

**Solution**: Already configured in your setup. Try `:checkhealth` if issues.

---

## Quick Reference Card

```
GITHUB PR OPERATIONS (<leader>g prefix)

Pull Requests:
  <leader>gpl   List PRs
  <leader>gpc   Create PR
  <leader>gpo   Checkout PR
  <leader>gpr   Start review
  <leader>gps   Check CI status
  <leader>gpm   Merge PR

Issues:
  <leader>gil   List issues
  <leader>gic   Create issue
  <leader>gio   Close issue

Review:
  <leader>grs   Start review
  <leader>grc   Review commit
  <leader>gra   Approve PR
  <leader>grr   Request changes

Search:
  <leader>gss   Search issues/PRs

In PR Buffer:
  <leader>ca    Add comment
  <leader>cs    Add suggestion
  <C-b>         Open in browser
  gf            Go to file
  ]c/[c         Next/prev comment
```

---

## Related Workflows

- **Git**: Use `<leader>gg` (lazygit) for local commits
- **Testing**: Run `<leader>a` before creating PR
- **Refactoring**: Use `<leader>R*` then create PR
- **Code Review**: Use Octo + diffview for reviews

---

## Further Reading

- Octo docs: `:help octo`
- GitHub: https://github.com/pwntester/octo.nvim
- gh CLI docs: https://cli.github.com/manual/
- Config: `lua/mike-custom/config/git.lua`

---

**Next**: Try creating a PR for a small change using `<leader>gpc`!
