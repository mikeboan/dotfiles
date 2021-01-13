# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/michaelboan/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/michaelboan/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/michaelboan/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/michaelboan/bin/google-cloud-sdk/completion.zsh.inc'; fi

export VAULT_ADDR="https://vault.svc.tapad.com:8200"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME='spaceship'
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  node
  ruby
  gcloud
  exec_time
  line_sep
  jobs
  char
)
SPACESHIP_CHAR_SYMBOL='↪ '
SPACESHIP_RUBY_SYMBOL='⧩ '

plugins=(
  git
  nvm
  osx
  rails
  tmuxinator
  yarn
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Setup fzf
# ---------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ $- == *i* ]] && source '/usr/local/opt/fzf/shell/completion.zsh' 2> /dev/null
source '/usr/local/opt/fzf/shell/key-bindings.zsh'
PATH=$PATH:/usr/local/sbin

export PATH="$PATH:$HOME/bin"

export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

export EDITOR='vim'

export CLOUDSDK_PYTHON=python2


# fix tmuxinator window titles
export DISABLE_AUTO_TITLE=true

# fix HEAD^
unsetopt nomatch

# Aliases
alias be='bundle exec'
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias mux='tmuxinator'
alias reload='source ~/.zshrc'
alias tmuxconf='vim ~/.tmux.conf'
alias vimrc='vim ~/.vim/vimrc'
alias v='vim'
alias zshrc='vim ~/.zshrc'
export PATH="/usr/local/opt/helm@2/bin:$PATH"



