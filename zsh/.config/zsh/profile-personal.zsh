# Personal-machine-only shell config — sourced by .zshrc when
# ~/.dotfiles-profile is "personal". Kept out of the work profile because
# these tools aren't installed or relevant on corporate machines.

# fnm — Node version manager; auto-switches on cd into dirs with .nvmrc
eval "$(fnm env --use-on-cd --shell zsh)"

# rbenv setup
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash zsh)"
