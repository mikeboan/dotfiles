#!/usr/bin/env bash
# Claude Code status line — mirrors Starship prompt (Tokyo Night Storm palette)

# Tokyo Night Storm colors (ANSI 256-color approximations via truecolor)
LAVENDER='\033[38;2;183;189;248m'   # #b7bdf8
SAPPHIRE='\033[38;2;122;162;247m'   # #7aa2f7
GREEN='\033[38;2;158;206;106m'      # #9ece6a
YELLOW='\033[38;2;224;175;104m'     # #e0af68
COMMENT='\033[38;2;86;95;137m'      # #565f89 (Tokyo Night Storm comment color)
BOLD='\033[1m'
RESET='\033[0m'
BG_DARK='\033[38;2;26;27;38m' # #1a1b26 (Tokyo Night bg as fg for contrast)
# Vim mode background colors (Tokyo Night Storm)
BG_BLUE='\033[48;2;122;162;247m'     # #7aa2f7 NORMAL
BG_GREEN='\033[48;2;158;206;106m'    # #9ece6a INSERT
BG_PURPLE='\033[48;2;187;154;247m'   # #bb9af7 VISUAL
BG_RED='\033[48;2;247;118;142m'      # #f7768e REPLACE
BG_YELLOW='\033[48;2;224;175;104m'   # #e0af68 COMMAND

input=$(cat)

# --- Left side ---
user=$(whoami)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
# Abbreviate home directory
dir="${dir/#$HOME/~}"
# Find git repo root (if in a git repo)
raw_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
git_root=$(git -C "$raw_dir" --no-optional-locks rev-parse --show-toplevel 2>/dev/null)
git_root_name=""
if [ -n "$git_root" ]; then
    git_root_name="${git_root##*/}"
    if [ "$raw_dir" = "$git_root" ]; then
        # At repo root — just show the dir name
        dir="$git_root_name"
    else
        # In a subdirectory — show repo-name/fish-shortened/subpath
        subpath="${raw_dir#$git_root/}"
        IFS='/' read -ra parts <<< "$subpath"
        count=${#parts[@]}
        result="$git_root_name"
        for ((i=0; i<count-1; i++)); do
            seg="${parts[$i]}"
            if [[ "$seg" == .* ]]; then
                result="${result}/${seg:0:2}"
            else
                result="${result}/${seg:0:1}"
            fi
        done
        dir="${result}/${parts[$count-1]}"
    fi
else
    # Not in a git repo — fish-style shorten the full path
    IFS='/' read -ra parts <<< "$dir"
    count=${#parts[@]}
    if [ "$count" -gt 1 ]; then
        result=""
        for ((i=0; i<count-1; i++)); do
            seg="${parts[$i]}"
            if [ "$i" -eq 0 ] && [ "$seg" = "~" ]; then
                result="~"
            elif [ -n "$seg" ]; then
                if [[ "$seg" == .* ]]; then
                    result="${result}/${seg:0:2}"
                else
                    result="${result}/${seg:0:1}"
                fi
            fi
        done
        dir="${result}/${parts[$count-1]}"
    fi
fi

# Git branch (skip optional locks)
git_branch=""
if git -C "$(echo "$input" | jq -r '.workspace.current_dir // .cwd')" \
    --no-optional-locks rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -C "$(echo "$input" | jq -r '.workspace.current_dir // .cwd')" \
        --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch="$branch"
    fi
fi

# Worktree detection — if cwd is inside .claude/worktrees/<name>, show the worktree name
worktree_name=""
if [[ "$raw_dir" == */.claude/worktrees/* ]]; then
    # Extract worktree name from path
    wt_path="${raw_dir#*/.claude/worktrees/}"
    worktree_name="${wt_path%%/*}"
fi

# --- Right side ---
model=$(echo "$input" | jq -r '.model.display_name // .model.id // ""')

# Token counts for context display
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')

# Format token count to compact form (e.g., 28400 -> "28k", 1500 -> "1.5k", 200000 -> "200k")
fmt_tokens() {
    local n=$1
    if [ "$n" -ge 1000 ]; then
        local k=$((n / 1000))
        local r=$(( (n % 1000) / 100 ))
        if [ "$r" -gt 0 ] && [ "$k" -lt 100 ]; then
            echo "${k}.${r}k"
        else
            echo "${k}k"
        fi
    else
        echo "$n"
    fi
}

# Context usage percentage (pre-calculated)
ctx_percent=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build context fraction (used/window)
ctx_fraction=""
if [ "$window_size" -gt 0 ]; then
    used_tokens=$((total_input + total_output))
    ctx_fraction=" $(fmt_tokens $used_tokens)/$(fmt_tokens $window_size)"
fi

# Build cache read display
cache_display=""
if [ "$cache_read" -gt 0 ]; then
    cache_display=" ⛁ $(fmt_tokens $cache_read)"
fi

# Vim mode indicator (mini.statusline narrow style)
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
vim_display=""
vim_plain=""
if [ -n "$vim_mode" ]; then
    letter="${vim_mode:0:1}"
    case "$vim_mode" in
        NORMAL)  bg="$BG_BLUE" ;;
        INSERT)  bg="$BG_GREEN" ;;
        VISUAL*) bg="$BG_PURPLE" ;;
        REPLACE) bg="$BG_RED" ;;
        COMMAND) bg="$BG_YELLOW" ;;
        *)       bg="$BG_BLUE" ;;
    esac
    vim_display="${bg}${BG_DARK}${BOLD} ${letter} ${RESET} "
    vim_plain=" ${letter}  "
fi

# --- Assemble ---
# Print vim mode block (if active)
if [ -n "$vim_display" ]; then
    printf "${vim_display}"
fi

# Print username + directory
printf "${LAVENDER}${BOLD}${user}${RESET} "
printf "${SAPPHIRE}${dir}${RESET}"

# Print worktree name (if in a worktree)
if [ -n "$worktree_name" ]; then
    printf " ${YELLOW}wt:${worktree_name}${RESET}"
fi

# Print git branch (if in a repo)
if [ -n "$git_branch" ]; then
    printf " ${GREEN}${git_branch}${RESET}"
fi

# Print separator + model + context + cache inline
printf " ${COMMENT}·${RESET} "
printf "${YELLOW}${model}${RESET}"
if [ -n "$ctx_percent" ]; then
    printf "${COMMENT} ${ctx_percent%%.*}%%${RESET}"
fi
if [ -n "$ctx_fraction" ]; then
    printf "${LAVENDER}${ctx_fraction}${RESET}"
fi
if [ -n "$cache_display" ]; then
    printf "${COMMENT}${cache_display}${RESET}"
fi
