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
    poetry
    heroku
    autoenv
)

source $ZSH/oh-my-zsh.sh

# Source central theme configuration
source "$HOME/.config/dotfiles/theme.sh"

# Configure zsh-syntax-highlighting colors using theme variables
# Must come after sourcing oh-my-zsh and theme.sh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=$THEME_GREEN"                        # green - valid commands
ZSH_HIGHLIGHT_STYLES[alias]="fg=$THEME_GREEN"                          # green - aliases
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$THEME_BLUE"                         # blue - builtins
ZSH_HIGHLIGHT_STYLES[function]="fg=$THEME_BLUE"                        # blue - functions
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=$THEME_FG"    # fg
ZSH_HIGHLIGHT_STYLES[path]="fg=$THEME_FG,underline"                    # fg with underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=$THEME_FG"                # fg
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="fg=$THEME_FG"         # fg
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$THEME_YELLOW"          # yellow - options
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$THEME_YELLOW"          # yellow - options
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$THEME_GREEN"                           # green
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$THEME_GREEN,italic"              # green italic
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$THEME_YELLOW"        # yellow - strings
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$THEME_YELLOW"        # yellow - strings
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$THEME_YELLOW"        # yellow - strings
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=$THEME_GREEN"  # green - vars in strings
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=$THEME_ORANGE"   # orange - escapes
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=$THEME_ORANGE"   # orange - escapes
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$THEME_FG"                       # fg
ZSH_HIGHLIGHT_STYLES[comment]="fg=$THEME_COMMENT"                      # comment - dimmed
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$THEME_RED"                    # red - errors
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$THEME_MAGENTA"                # magenta - keywords

export EDITOR='nvim'

# -----

# enable brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# enable starship prompt (must come after brew)
eval "$(starship init zsh)"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/dotfiles/bin"

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

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

# --- BEAMJOBS UTILS --- #

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

alias startClientTunnel='ngrok http 8888 --subdomain bjclient-mike'
alias startServerTunnel='ngrok http 8080 --subdomain bjserver-mike'

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

export DAGSTER_HOME="~/.dagster_home"

alias tx='tmuxinator'
alias bj='tmuxinator start beamjobs'
alias bj2='tmuxinator start beamjobs2'
alias dotfiles='tmuxinator start dotfiles'
alias wajtd='tmuxinator start wajtd'

alias lg='lazygit'

# --- MODERN CLI TOOL ALIASES --- #
# Use modern replacements with convenient shortcuts
# alias cat='bat'              # bat instead of cat
# alias ls='eza'               # eza instead of ls
# alias ll='eza -lah'          # long format with all files
# alias lt='eza --tree'        # tree view
# alias df='duf'               # duf instead of df
# alias du='dust'              # dust instead of du
# alias ps='procs'             # procs instead of ps
# alias top='btop'             # btop instead of top

# Git delta configuration (better diffs)
export GIT_PAGER='delta'

# --- LOCAL CONFIG --- #
# Source local config if it exists (for work-specific settings, secrets, etc.)
# This file is gitignored and should contain machine/work-specific config
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
