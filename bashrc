# initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### load extenstions ###
source "$HOME/.git-completion.bash"
source "$HOME/.git-prompt.sh"

### ENV variables ###

# look for commands in these places
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export SCALA_HOME=/usr/local/share/scala
export PATH=$PATH:$SCALA_HOME/bin

# make vim the default text editor
export EDITOR="vim"

# shortened prompt that includes git branch info


random_color () {
  echo $(($RANDOM % 6 + 1 + 30))
}

random_background () {
  echo $(($RANDOM % 6 + 1 + 40))
}


RED='\[\e[1;31m\]'
GREEN='\[\e[1;32m\]'
TEAL='\[\e[1;36m\]'
WHITE='\[\e[1;37m\]'
RESET='\[\e[0m\]'


smiley () {
  if [ $? = 0 ]; then
     echo -e ":)"
  else
     echo -e ":("
  fi

}
export PS1="\n\[\e[1;\$(random_background)m\]\w$RESET$WHITE\$(__git_ps1) $WHITE\$(smiley)$WHITE \n> $RESET"


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
