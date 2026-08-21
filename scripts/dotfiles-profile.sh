#!/bin/bash

# Shared helper: resolve the personal/work profile for this machine.
# Source this file, then call `dotfiles_profile` — it echoes "personal" or
# "work", persisting the answer to ~/.dotfiles-profile so future runs of
# install.sh / bootstrap.sh don't re-prompt.

# The only two profiles that mean anything. Anything else is a typo.
_dotfiles_profile_is_valid() {
    case "$1" in
        personal|work) return 0 ;;
        *) return 1 ;;
    esac
}

dotfiles_profile() {
    local profile_file="$HOME/.dotfiles-profile"

    # An explicit override wins. A typo here fails loudly rather than quietly
    # downgrading the machine to the work profile.
    if [ -n "$DOTFILES_PROFILE" ]; then
        if ! _dotfiles_profile_is_valid "$DOTFILES_PROFILE"; then
            echo "❌ DOTFILES_PROFILE must be 'personal' or 'work' (got '$DOTFILES_PROFILE')" >&2
            return 1
        fi
        echo "$DOTFILES_PROFILE" > "$profile_file"
        echo "$DOTFILES_PROFILE"
        return
    fi

    # A cached answer is trusted only if it's still one of the two valid
    # values — a hand-edited or truncated file re-prompts instead of silently
    # deciding the machine is a work machine.
    if [ -f "$profile_file" ]; then
        local cached
        cached="$(cat "$profile_file")"
        if _dotfiles_profile_is_valid "$cached"; then
            echo "$cached"
            return
        fi
        echo "⚠️  Ignoring unrecognized profile '$cached' in $profile_file" >&2
    fi

    if [ -t 0 ]; then
        local answer
        while true; do
            read -r -p "Is this a personal or work machine? [personal/work]: " answer || return 1
            _dotfiles_profile_is_valid "$answer" && break
            echo "   Please answer 'personal' or 'work'." >&2
        done
        echo "$answer" > "$profile_file"
        echo "$answer"
    else
        # Nothing cached and no tty to ask: assume the restrictive profile.
        echo "work"
    fi
}
