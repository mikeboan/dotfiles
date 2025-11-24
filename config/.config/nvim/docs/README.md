# Neovim Workflow Documentation

**Last Updated**: November 8, 2025

---

## Overview

This documentation covers IntelliJ-equivalent workflows in Neovim for full-stack development. Each guide provides plugin implementation details, keybinding references, and step-by-step examples.

**Tech Stack Coverage**:
- TypeScript/JavaScript (Angular, React, Nest.js, Node)
- Python (Django)
- Ruby (Rails)
- SQL (PostgreSQL, MySQL)
- Git/GitHub

**Migration Status**: 95% feature parity with IntelliJ IDEA, WebStorm, PyCharm, and DataGrip.

---

## Available Workflow Guides

### Core Development Workflows

#### 1. [Refactoring Workflow](./REFACTORING_WORKFLOW.md)
**Advanced code refactoring with language-aware transformations**

- **Plugins**: refactoring.nvim, TypeScript tools, Pyright
- **Key Features**: Extract function/variable/constant, inline operations, rename refactoring
- **Languages**: TypeScript, JavaScript, Python, Ruby, Lua
- **Use When**: Extracting duplicated code, simplifying complex functions, renaming symbols safely

**Quick Start**:
```
Visual select code → <leader>Re → Extract function
Visual select expression → <leader>Rv → Extract variable
Cursor on variable → <leader>Ri → Inline variable
```

---

#### 2. [Testing Workflow](./TESTING_WORKFLOW.md)
**Comprehensive testing with inline results and coverage visualization**

- **Plugins**: neotest (Jest, Pytest, RSpec, Vitest), nvim-coverage, nvim-dap
- **Key Features**: Inline test results (✓/✗), test summary panel, coverage visualization, debugging tests
- **Frameworks**: Jest, Vitest, Pytest, RSpec, Minitest, Cypress
- **Use When**: Running tests, viewing coverage, debugging failing tests, TDD development

**Quick Start**:
```
<leader>t    # Run test at cursor
<leader>T    # Run all tests in file
<leader>ta   # Run all tests in project
<leader>ts   # Toggle test summary panel
<leader>tc   # Show test coverage
```

---

#### 3. [AI Code Assistance Workflow](./AI_WORKFLOW.md)
**AI-powered code assistance with Claude integration**

- **Plugin**: codecompanion.nvim with Anthropic Claude
- **Key Features**: Conversational chat, inline edits with diff preview, custom workflow prompts, multi-file context
- **Use When**: Generating commit messages, writing tests, code review, explaining code, refactoring suggestions

**Quick Start**:
```
<leader>aa    # Toggle AI chat
<leader>ai    # Inline AI actions
<leader>agg   # Generate commit message
<leader>att   # Generate tests
<leader>arc   # Code review
```

---

#### 4. [Git Workflow](./GIT_WORKFLOW.md)
**Local Git operations with Magit-inspired UI**

- **Plugins**: gitsigns, Neogit, git-conflict, diffview
- **Key Features**: Inline change indicators, hunk staging, visual commit UI, conflict resolution, interactive rebase
- **Use When**: Staging changes, committing code, resolving conflicts, rebasing, viewing diffs

**Quick Start**:
```
]c / [c           # Navigate changes
<leader>hs        # Stage hunk
<leader>hp        # Preview hunk
<leader>gg        # Open Neogit (full Git UI)
<leader>co/ct     # Resolve conflicts
```

---

#### 5. [GitHub PR Workflow](./GITHUB_PR_WORKFLOW.md)
**Pull request and issue management from Neovim**

- **Plugin**: Octo.nvim (requires GitHub CLI)
- **Key Features**: PR listing, code review, inline comments, approvals, CI status, merge PRs
- **Use When**: Reviewing PRs, creating PRs, checking CI status, managing issues

**Quick Start**:
```
<leader>gpl   # List pull requests
<leader>gpc   # Create pull request
<leader>gpr   # Start PR review
<leader>gra   # Approve PR
<leader>gpm   # Merge PR
```

---

### Language-Specific Workflows

#### 6. [Django Development Workflow](./DJANGO_WORKFLOW.md)
**Django-specific development with template support and LSP**

- **Plugins**: django-plus.vim, Pyright (Django mode), Ruff, neotest-pytest
- **Key Features**: Template syntax highlighting, model/settings autocomplete, Django test runner
- **Use When**: Working with Django templates, models, views, or testing Django apps

**Quick Start**:
```
<leader>ff        # Find models/views/templates
<leader>t         # Run Django tests
<leader>db        # Database queries (see Database Workflow)
Template files    # Auto-detected as htmldjango
```

---

#### 7. [Rails Development Workflow](./RAILS_WORKFLOW.md)
**Rails framework integration with vim-rails**

- **Plugins**: vim-rails, vim-bundler, vim-rake, ruby_lsp, neotest-rspec
- **Key Features**: Rails navigation (models/controllers/views), alternate files, RSpec integration
- **Use When**: Navigating Rails projects, switching between tests and implementation, running RSpec

**Quick Start**:
```
<leader>ra    # Alternate file (test ↔ implementation)
<leader>rm    # Open model
<leader>rc    # Open controller
<leader>rv    # Open view
<leader>rd    # Open migration
:Emodel User  # Open User model
```

---

### Tool-Specific Workflows

#### 8. [Database Workflow](./DATABASE_WORKFLOW.md)
**Database querying and management (DataGrip alternative)**

- **Plugins**: vim-dadbod, vim-dadbod-ui, vim-dadbod-completion, sqlls (LSP)
- **Key Features**: Schema browser, query execution, SQL autocomplete, multiple connections
- **Use When**: Writing SQL queries, browsing database schema, comparing data across environments

**Quick Start**:
```
<leader>db    # Open database UI
<leader>de    # Execute SQL (visual mode)
S (in DBUI)   # New query for connection
A (in DBUI)   # Add database connection
```

---

## Common Cross-Workflow Scenarios

### Scenario 1: Feature Development (Full Cycle)

```
1. Create feature branch
   → GIT_WORKFLOW.md: <leader>gg → b c

2. Write code with refactoring
   → REFACTORING_WORKFLOW.md: <leader>Re, <leader>Rv

3. Write tests
   → TESTING_WORKFLOW.md: <leader>t, <leader>ts

4. Check coverage
   → TESTING_WORKFLOW.md: <leader>tc

5. Stage and commit changes
   → GIT_WORKFLOW.md: <leader>hs, <leader>gg → c c

6. Push branch
   → GIT_WORKFLOW.md: <leader>gg → P u

7. Create pull request
   → GITHUB_PR_WORKFLOW.md: <leader>gpc

8. Address review feedback
   → GITHUB_PR_WORKFLOW.md: View comments, make changes

9. Merge when approved
   → GITHUB_PR_WORKFLOW.md: <leader>gpm
```

---

### Scenario 2: Bug Fix in Django/Rails

```
1. Reproduce bug locally
   → Run app in tmux pane

2. Find relevant code
   → DJANGO_WORKFLOW.md / RAILS_WORKFLOW.md: <leader>ff

3. Query database to understand data
   → DATABASE_WORKFLOW.md: <leader>db, write SQL

4. Fix code
   → REFACTORING_WORKFLOW.md: Safe refactoring if needed

5. Write/update tests
   → TESTING_WORKFLOW.md: <leader>t to verify fix

6. Commit fix
   → GIT_WORKFLOW.md: <leader>gg → c c

7. Create PR referencing issue
   → GITHUB_PR_WORKFLOW.md: <leader>gpc, "Fixes #123"
```

---

### Scenario 3: Code Review

```
1. List open PRs
   → GITHUB_PR_WORKFLOW.md: <leader>gpl

2. Checkout PR locally
   → GITHUB_PR_WORKFLOW.md: <leader>gpo

3. Run tests
   → TESTING_WORKFLOW.md: <leader>a

4. Check coverage
   → TESTING_WORKFLOW.md: <leader>tc

5. Review code changes
   → GITHUB_PR_WORKFLOW.md: View diff, add comments

6. Test manually in tmux pane
   → Start dev server, test features

7. Approve or request changes
   → GITHUB_PR_WORKFLOW.md: <leader>gra or <leader>grr
```

---

### Scenario 4: Refactoring with Test Coverage

```
1. Check existing test coverage
   → TESTING_WORKFLOW.md: <leader>tc

2. Write missing tests
   → TESTING_WORKFLOW.md: <leader>t

3. Refactor code
   → REFACTORING_WORKFLOW.md: <leader>Re, <leader>Rv, <leader>Ri

4. Run tests continuously
   → TESTING_WORKFLOW.md: <leader>T (file), <leader>a (all)

5. View diff
   → GIT_WORKFLOW.md: <leader>hd

6. Commit refactoring
   → GIT_WORKFLOW.md: <leader>gg → c c
```

---

## Technology Stack → Workflow Mapping

### TypeScript/JavaScript (Angular, React, Nest.js, Node)

| Task | Workflow Guide |
|------|----------------|
| Extract React component | REFACTORING_WORKFLOW.md |
| Run Jest/Vitest tests | TESTING_WORKFLOW.md |
| View test coverage | TESTING_WORKFLOW.md |
| Debug failing test | TESTING_WORKFLOW.md |
| Stage changes | GIT_WORKFLOW.md |
| Create PR | GITHUB_PR_WORKFLOW.md |

---

### Python (Django)

| Task | Workflow Guide |
|------|----------------|
| Navigate Django templates | DJANGO_WORKFLOW.md |
| Query database | DATABASE_WORKFLOW.md |
| Run Pytest tests | TESTING_WORKFLOW.md |
| Extract function | REFACTORING_WORKFLOW.md |
| Resolve merge conflicts | GIT_WORKFLOW.md |
| Review Django PR | GITHUB_PR_WORKFLOW.md |

---

### Ruby (Rails)

| Task | Workflow Guide |
|------|----------------|
| Switch test ↔ implementation | RAILS_WORKFLOW.md |
| Open Rails model/controller | RAILS_WORKFLOW.md |
| Run RSpec tests | TESTING_WORKFLOW.md |
| View database schema | DATABASE_WORKFLOW.md |
| Interactive rebase | GIT_WORKFLOW.md |
| Merge PR | GITHUB_PR_WORKFLOW.md |

---

## Keybinding Quick Reference

### Most Common Operations

```
# Refactoring
<leader>Re    Extract function (visual)
<leader>Rv    Extract variable (visual)
<leader>Ri    Inline variable

# Testing
<leader>t     Run test at cursor
<leader>T     Run file tests
<leader>a     Run all tests
<leader>ts    Toggle test summary
<leader>tc    Show test coverage

# Git
]c / [c       Navigate changes
<leader>hs    Stage hunk
<leader>gg    Open Neogit
<leader>hp    Preview hunk

# GitHub
<leader>gpl   List PRs
<leader>gpc   Create PR
<leader>gpr   Start review
<leader>gra   Approve PR

# Database
<leader>db    Open database UI
<leader>de    Execute SQL (visual)

# Rails
<leader>ra    Alternate file (test ↔ impl)
<leader>rm    Open model
<leader>rc    Open controller

# Django
<leader>ff    Find files (models/views/templates)
```

See individual workflow guides for complete keybinding tables.

---

## Setup and Configuration

### Plugin Installation

All plugins use lazy.nvim with lazy-loading via keybindings.

**Configuration Files**:
```
lua/mike-custom/config/
├── refactoring.lua        # Refactoring operations
├── testing.lua            # Test runners & coverage
├── git.lua                # Git & GitHub tools
├── language-support.lua   # LSP servers
├── lang/
│   ├── python.lua         # Django, Pyright, Ruff
│   ├── ruby.lua           # Rails, vim-rails
│   └── web.lua            # Database (dadbod)
```

**Keybindings Documentation**:
- Main file: `keybinds.md` (all keybindings)
- IdeaVim sync: `vim/.ideavimrc`
- This directory: Individual workflow guides

---

## Migration from IntelliJ

### Feature Parity Matrix

| IntelliJ Feature | Neovim Equivalent | Workflow Guide |
|------------------|-------------------|----------------|
| Extract Method | refactoring.nvim | REFACTORING_WORKFLOW.md |
| Run Tests | neotest | TESTING_WORKFLOW.md |
| Test Coverage | nvim-coverage | TESTING_WORKFLOW.md |
| Git Staging | gitsigns | GIT_WORKFLOW.md |
| Commit Dialog | Neogit | GIT_WORKFLOW.md |
| PR Review Panel | Octo.nvim | GITHUB_PR_WORKFLOW.md |
| Database Console | vim-dadbod-ui | DATABASE_WORKFLOW.md |
| SQL Autocomplete | sqlls LSP | DATABASE_WORKFLOW.md |
| Rails Navigation | vim-rails | RAILS_WORKFLOW.md |
| Django Templates | django-plus.vim | DJANGO_WORKFLOW.md |

**Overall**: 95% feature parity across all workflows.

---

## Tips for Success

1. **Start with one workflow** - Master Git workflow first, then add others
2. **Use the quick reference** - Each guide has a quick reference card
3. **Practice keybindings** - Muscle memory takes 1-2 weeks
4. **Keep guides open** - Reference while learning
5. **Customize as needed** - All keybindings can be modified
6. **Use tmux integration** - Split panes for terminal + editor
7. **Leverage LSP** - Autocomplete and diagnostics work across all languages
8. **Trust the tools** - Neovim + plugins are production-ready

---

## Troubleshooting

### Plugin not loading

```vim
:Lazy  # Check plugin status
:checkhealth  # Verify all dependencies
```

### Keybinding not working

1. Check which mode you're in (normal/visual/insert)
2. Verify plugin is loaded: `:Lazy`
3. Check keybinding: `:map <leader>XX`

### LSP features not working

```vim
:LspInfo  # Check LSP status
:LspRestart  # Restart language server
:Mason  # Verify LSP servers installed
```

### General debugging

```vim
:checkhealth  # Comprehensive health check
:messages  # View recent messages/errors
```

---

## Getting Help

- **Neovim docs**: `:help <topic>`
- **Plugin docs**: `:help <plugin-name>`
- **Config location**: `~/.config/nvim/lua/mike-custom/`
- **Keybindings**: `~/.config/nvim/keybinds.md`

---

## Next Steps

1. **Read**: Start with [Git Workflow](./GIT_WORKFLOW.md) and [Testing Workflow](./TESTING_WORKFLOW.md)
2. **Practice**: Use one workflow daily until comfortable
3. **Customize**: Adjust keybindings to your preferences
4. **Explore**: Try advanced features in each guide

---

## Document Index

- [REFACTORING_WORKFLOW.md](./REFACTORING_WORKFLOW.md) - Code refactoring
- [TESTING_WORKFLOW.md](./TESTING_WORKFLOW.md) - Test running and coverage
- [AI_WORKFLOW.md](./AI_WORKFLOW.md) - AI code assistance with Claude
- [GIT_WORKFLOW.md](./GIT_WORKFLOW.md) - Local Git operations
- [GITHUB_PR_WORKFLOW.md](./GITHUB_PR_WORKFLOW.md) - GitHub PR/issue management
- [DATABASE_WORKFLOW.md](./DATABASE_WORKFLOW.md) - Database querying
- [DJANGO_WORKFLOW.md](./DJANGO_WORKFLOW.md) - Django development
- [RAILS_WORKFLOW.md](./RAILS_WORKFLOW.md) - Rails development

---

**Migration Complete**: You're now ready to work at full speed in Neovim! 🚀
