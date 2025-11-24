# New Tools Quick Reference

This guide covers the new modern CLI tools added to your dotfiles and how to use them.

## Modern CLI Replacements

### bat (better cat)
Syntax-highlighted file viewer with git integration.

```bash
bat file.js              # View with syntax highlighting
bat -n file.py           # Show line numbers
bat --diff file.rs       # Show git diff
```

**Alias:** `cat` → `bat`

### eza (better ls)
Modern replacement for ls with colors and icons.

```bash
eza                      # Basic listing
eza -lah                 # Long format with all files
eza --tree               # Tree view
eza --git                # Show git status
eza -lah --sort=modified # Sort by modification time
```

**Aliases:**
- `ls` → `eza`
- `ll` → `eza -lah`
- `lt` → `eza --tree`

### btop (better top)
Beautiful process viewer with graphs and colors.

```bash
btop                     # Launch interactive process viewer
```

**Alias:** `top` → `btop`

**Keys:**
- `q` - quit
- `f` - filter
- `k` - kill process
- `m` - sort by memory
- `c` - sort by CPU

### duf (better df)
User-friendly disk usage viewer.

```bash
duf                      # Show all mounted filesystems
duf /Users               # Show specific path
```

**Alias:** `df` → `duf`

### dust (better du)
Fast directory size analyzer.

```bash
dust                     # Show sizes in current dir
dust -d 2                # Limit depth to 2 levels
dust -r                  # Reverse order (smallest first)
dust /Users/mike         # Analyze specific directory
```

**Alias:** `du` → `dust`

### procs (better ps)
Modern process viewer with color and search.

```bash
procs                    # Show all processes
procs firefox            # Search for specific process
procs --tree             # Show process tree
procs --watch            # Watch mode (updates every 1s)
```

**Alias:** `ps` → `procs`

## Git Tools

### git-delta (better git diff)
Syntax-highlighting pager for git, diff, and grep output.

Already configured in your `.gitconfig`. Just use normal git commands:

```bash
git diff                 # Beautiful side-by-side diff
git log -p               # Pretty commit logs with diffs
git show HEAD            # Syntax-highlighted commit details
```

**Navigation:**
- `n` / `N` - Next/previous file
- `q` - Quit

Your configuration:
- Side-by-side view enabled
- Line numbers enabled
- Navigate between files
- Color moved code detection

## Development Utilities

### httpie (better curl)
User-friendly HTTP client.

```bash
http GET https://api.github.com/users/mikeboan
http POST https://httpbin.org/post name=mike email=mike@example.com
http --download https://example.com/file.zip
http --session=logged-in GET https://example.com/api/user
```

**Features:**
- JSON by default
- Syntax highlighting
- Form submissions
- File uploads
- Session support

### jq (JSON processor)
Parse and manipulate JSON from the command line.

```bash
curl https://api.github.com/users/mikeboan | jq .
echo '{"name":"mike","age":30}' | jq .name
cat package.json | jq .dependencies
jq -r '.[] | .name' users.json    # Raw output
```

### yq (YAML processor)
Like jq, but for YAML.

```bash
yq . config.yaml                  # Pretty-print YAML
yq .services.web.image docker-compose.yml
yq -o json . config.yaml          # Convert to JSON
```

### tldr (simplified man pages)
Community-driven man pages with practical examples.

```bash
tldr tar                 # Quick tar examples
tldr git-commit          # Git command examples
tldr -u                  # Update cache
```

### glow (markdown renderer)
Render markdown files beautifully in the terminal.

```bash
glow README.md           # Render and page through
glow -p README.md        # Just print, don't page
glow -w 100 README.md    # Set width
glow                     # Find and display markdown files
```

### slides (terminal presentations)
Create and present slide decks in the terminal.

```bash
slides presentation.md   # Present slides
```

Create slides in markdown:
```markdown
# Slide 1
Content here

---

# Slide 2
More content
```

## Version Managers

### asdf (universal version manager)
One version manager for all languages.

```bash
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

asdf plugin add python
asdf install python 3.11.0
asdf local python 3.11.0    # Set for current directory
```

**Common commands:**
- `asdf list all nodejs` - List all available versions
- `asdf list nodejs` - List installed versions
- `asdf current` - Show all current versions
- `asdf plugin list all` - Show available plugins

## Tips

### Unalias if needed
If you need the original commands:

```bash
\cat file.txt            # Use original cat
\ls                      # Use original ls
command ls               # Another way to bypass alias
```

### Combining tools
```bash
# Find large files with dust and examine with bat
dust | head -10

# Use eza with fzf
eza -1 | fzf | xargs bat

# Use jq with httpie
http GET api.github.com/users/mikeboan | jq .public_repos

# Process git diffs
git diff | delta
```

### Check tool versions
```bash
bat --version
eza --version
git-delta --version
```

## Learning More

Each tool has excellent documentation:
- Run `man <tool>` or `<tool> --help`
- Use `tldr <tool>` for quick examples
- Visit the GitHub repos (linked in README.md)
