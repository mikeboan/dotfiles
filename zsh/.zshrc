# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

export ZSH="$HOME/.oh-my-zsh"

AUTOENV_ASSUME_YES='yes' # any non-empty string indicates 'yes'
AUTOENV_ENV_FILENAME='.beamspace'

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    nvm
    autoenv
)

source $ZSH/oh-my-zsh.sh

# zsh-syntax-highlighting colors — Tokyo Night Storm palette
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=#9ece6a"                        # green - valid commands
ZSH_HIGHLIGHT_STYLES[alias]="fg=#9ece6a"                          # green - aliases
ZSH_HIGHLIGHT_STYLES[builtin]="fg=#7aa2f7"                        # blue - builtins
ZSH_HIGHLIGHT_STYLES[function]="fg=#7aa2f7"                       # blue - functions
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=#c0caf5" # fg
ZSH_HIGHLIGHT_STYLES[path]="fg=#c0caf5,underline"                 # fg with underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=#c0caf5"             # fg
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="fg=#c0caf5"      # fg
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#e0af68"           # yellow - options
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#e0af68"           # yellow - options
ZSH_HIGHLIGHT_STYLES[arg0]="fg=#9ece6a"                           # green
ZSH_HIGHLIGHT_STYLES[precommand]="fg=#9ece6a,italic"              # green italic
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=#e0af68"         # yellow - strings
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=#e0af68"         # yellow - strings
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=#e0af68"         # yellow - strings
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=#9ece6a"  # green - vars in strings
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=#ff9e64"    # orange - escapes
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=#ff9e64"    # orange - escapes
ZSH_HIGHLIGHT_STYLES[redirection]="fg=#c0caf5"                    # fg
ZSH_HIGHLIGHT_STYLES[comment]="fg=#565f89"                        # comment - dimmed
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#f7768e"                  # red - errors
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=#bb9af7"                  # magenta - keywords

export EDITOR='nvim'

# -----

# enable brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Keep nvm's node ahead of Homebrew's.
# The oh-my-zsh `nvm` plugin (loaded above) prepends nvm's node to PATH, but the
# `brew shellenv` line then re-prepends /opt/homebrew/bin in front of it, so a
# brew-installed `node` would shadow nvm. Re-assert nvm's active bin at the front.
# Bonus: with nvm's entry now first, later `nvm use` swaps it in place — staying
# ahead of brew instead of switching versions invisibly behind it.
[ -n "$NVM_BIN" ] && export PATH="$NVM_BIN:$PATH"
# Keep PATH entries unique (first occurrence wins). Collapses the duplicate nvm
# bin that the prepend above otherwise leaves behind, and dedupes PATH generally.
typeset -U path PATH

# enable starship prompt (must come after brew)
eval "$(starship init zsh)"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"

export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

# rbenv setup
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash zsh)"

# nvm auto-switch: automatically run `nvm use` when entering a directory with .nvmrc
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local nvmrc_path="$(nvm_find_nvmrc)"
#   if [ -n "$nvmrc_path" ]; then
#     local node_version="$(nvm version "$(cat "$nvmrc_path")")"
#     if [ "$node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$node_version" != "$(nvm version)" ]; then
#       nvm use
#     fi
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# system utilities installed via cargo (rust)
export PATH="$PATH:$HOME/.cargo/bin"

# --- git & github utils --- #

# Base branch of current PR.
alias gbase='gh pr view --json baseRefName -q ".baseRefName"'
alias gcurrent='git rev-parse --symbolic-full-name --abbrev-ref HEAD'
# Lists the first branch that uses current branch as base.
alias gnext='gh pr list --base `gcurrent` --limit 1 --json headRefName -q ".[].headRefName"'
# Lists ALL branches that use current branch as base.
alias gnextAll='gh pr list --base `gcurrent` --json headRefName -q ".[].headRefName"'
alias gcb='git checkout `gbase`'
alias gcn='git checkout `gnext`'
alias gcs='git checkout staging'
alias gcm='git checkout main'
alias gmb='git merge `gbase` --no-edit'
alias gd='git branch -D'
alias gdb='`gd` `gbase`'
# Push/pull the current branch. Taken from:
# https://stackoverflow.com/a/67507740
alias gpush='git push origin "$(git symbolic-ref --short HEAD)"'
alias gpull='git pull origin "$(git symbolic-ref --short HEAD)"'
alias gchain='`gcn`;git merge `gbase` --no-edit;`gpush`'

# make `vi` and `vim` launch neovim
alias vim="nvim"
alias vi="nvim"
# access vim when needed by bypassing the new vim alias
alias oldvim="\vim"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source $HOME/fzf-git.sh/fzf-git.sh

eval "$(zoxide init zsh)"


alias dotfiles='sesh connect dotfiles'
alias wajtd='sesh connect wajtd'

alias lg='lazygit'

# yazi: `y` launches the file manager and cd's to its last dir on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# Edit current command line in $EDITOR with Ctrl+X Ctrl+E
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Opt+Left/Right → word-by-word cursor movement (kitty sends xterm-style sequences)
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# --- MODERN CLI TOOL ALIASES --- #
# Use modern replacements with convenient shortcuts
alias cat='bat --paging=never' # bat instead of cat (no paging so pipes work)
alias ls='eza'                 # eza instead of ls
alias ll='eza -lah'            # long format with all files
alias lt='eza --tree'          # tree view
alias df='duf'                 # duf instead of df
alias du='dust'                # dust instead of du
alias ps='procs'               # procs instead of ps
alias top='btop'               # btop instead of top
diskhog() { sudo ncdu -x "${1:-/}"; }

# Git delta configuration (better diffs)
export GIT_PAGER='delta'

# --- LOCAL CONFIG --- #
# Source local config if it exists (for work-specific settings, secrets, etc.)
# This file is gitignored and should contain machine/work-specific config
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
