# initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### load extenstions ###
source "$HOME/.git-completion.bash"
source "$HOME/.git-prompt.sh"

### ENV variables ###

# look for commands in these places
export PATH="$HOME/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# make vim the default text editor
export EDITOR="vim"

# shortened prompt that includes git branch info
RED='\[\e[0;31m\]'
WHITE='\[\e[1;37m\]'
RESET='\[\e[0m\]'
export PS1="$RED\W$WHITE\$(__git_ps1)$RED\$$RESET "

### other ###

# initialize node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# load aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# load any local configuration
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"

# load completion for charon
source "$HOME/bin/completion/charon.completion"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/michael.boan/bin/google-cloud-sdk/path.bash.inc' ]; then source '/Users/michael.boan/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/michael.boan/bin/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/michael.boan/bin/google-cloud-sdk/completion.bash.inc'; fi
