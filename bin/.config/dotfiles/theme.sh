#!/usr/bin/env bash
# Central theme configuration for dotfiles
# This file is sourced by various config files and defines the current color scheme

# Current active theme
export COLORSCHEME="tokyonight-storm"

# ============================================================================
# TOKYONIGHT STORM PALETTE
# ============================================================================
if [[ "$COLORSCHEME" == "tokyonight-storm" ]]; then
    export THEME_BG="#24283b"
    export THEME_BG_DARK="#1f2335"
    export THEME_BG_HIGHLIGHT="#292e42"
    export THEME_FG="#c0caf5"
    export THEME_FG_DARK="#a9b1d6"
    export THEME_FG_GUTTER="#3b4261"
    export THEME_COMMENT="#565f89"
    export THEME_DARK3="#545c7e"
    export THEME_DARK5="#737aa2"

    export THEME_RED="#f7768e"
    export THEME_RED1="#db4b4b"
    export THEME_ORANGE="#ff9e64"
    export THEME_YELLOW="#e0af68"
    export THEME_GREEN="#9ece6a"
    export THEME_GREEN1="#73daca"
    export THEME_GREEN2="#41a6b5"
    export THEME_CYAN="#7dcfff"
    export THEME_BLUE="#7aa2f7"
    export THEME_BLUE0="#3d59a1"
    export THEME_BLUE1="#2ac3de"
    export THEME_BLUE2="#0db9d7"
    export THEME_BLUE5="#89ddff"
    export THEME_BLUE6="#b4f9f8"
    export THEME_MAGENTA="#bb9af7"
    export THEME_MAGENTA2="#ff007c"
    export THEME_PURPLE="#9d7cd8"

    export THEME_TERMINAL_BLACK="#414868"

    # Application-specific theme names
    export NVIM_THEME="tokyonight-storm"
    export STARSHIP_PALETTE="tokyonight_storm"

# ============================================================================
# CATPPUCCIN MOCHA PALETTE
# ============================================================================
elif [[ "$COLORSCHEME" == "catppuccin-mocha" ]]; then
    export THEME_BG="#1e1e2e"
    export THEME_BG_DARK="#181825"
    export THEME_BG_HIGHLIGHT="#313244"
    export THEME_FG="#cdd6f4"
    export THEME_FG_DARK="#bac2de"
    export THEME_FG_GUTTER="#45475a"
    export THEME_COMMENT="#6c7086"
    export THEME_DARK3="#585b70"
    export THEME_DARK5="#7f849c"

    export THEME_RED="#f38ba8"
    export THEME_RED1="#eba0ac"
    export THEME_ORANGE="#fab387"
    export THEME_YELLOW="#f9e2af"
    export THEME_GREEN="#a6e3a1"
    export THEME_GREEN1="#94e2d5"
    export THEME_GREEN2="#89dceb"
    export THEME_CYAN="#89dceb"
    export THEME_BLUE="#89b4fa"
    export THEME_BLUE0="#74c7ec"
    export THEME_BLUE1="#74c7ec"
    export THEME_BLUE2="#89dceb"
    export THEME_BLUE5="#b4befe"
    export THEME_BLUE6="#cba6f7"
    export THEME_MAGENTA="#cba6f7"
    export THEME_MAGENTA2="#f5c2e7"
    export THEME_PURPLE="#cba6f7"

    export THEME_TERMINAL_BLACK="#45475a"

    export NVIM_THEME="catppuccin-mocha"
    export STARSHIP_PALETTE="catppuccin_mocha"

# ============================================================================
# CATPPUCCIN MACCHIATO PALETTE
# ============================================================================
elif [[ "$COLORSCHEME" == "catppuccin-macchiato" ]]; then
    export THEME_BG="#24273a"
    export THEME_BG_DARK="#1e2030"
    export THEME_BG_HIGHLIGHT="#363a4f"
    export THEME_FG="#cad3f5"
    export THEME_FG_DARK="#b8c0e0"
    export THEME_FG_GUTTER="#494d64"
    export THEME_COMMENT="#6e738d"
    export THEME_DARK3="#5b6078"
    export THEME_DARK5="#8087a2"

    export THEME_RED="#ed8796"
    export THEME_RED1="#ee99a0"
    export THEME_ORANGE="#f5a97f"
    export THEME_YELLOW="#eed49f"
    export THEME_GREEN="#a6da95"
    export THEME_GREEN1="#8bd5ca"
    export THEME_GREEN2="#91d7e3"
    export THEME_CYAN="#91d7e3"
    export THEME_BLUE="#8aadf4"
    export THEME_BLUE0="#7dc4e4"
    export THEME_BLUE1="#7dc4e4"
    export THEME_BLUE2="#91d7e3"
    export THEME_BLUE5="#b7bdf8"
    export THEME_BLUE6="#c6a0f6"
    export THEME_MAGENTA="#c6a0f6"
    export THEME_MAGENTA2="#f5bde6"
    export THEME_PURPLE="#c6a0f6"

    export THEME_TERMINAL_BLACK="#494d64"

    export NVIM_THEME="catppuccin-macchiato"
    export STARSHIP_PALETTE="catppuccin_macchiato"

# ============================================================================
# NORD PALETTE
# ============================================================================
elif [[ "$COLORSCHEME" == "nord" ]]; then
    export THEME_BG="#2e3440"
    export THEME_BG_DARK="#2e3440"
    export THEME_BG_HIGHLIGHT="#3b4252"
    export THEME_FG="#eceff4"
    export THEME_FG_DARK="#e5e9f0"
    export THEME_FG_GUTTER="#4c566a"
    export THEME_COMMENT="#616e88"
    export THEME_DARK3="#4c566a"
    export THEME_DARK5="#5e81ac"

    export THEME_RED="#bf616a"
    export THEME_RED1="#bf616a"
    export THEME_ORANGE="#d08770"
    export THEME_YELLOW="#ebcb8b"
    export THEME_GREEN="#a3be8c"
    export THEME_GREEN1="#8fbcbb"
    export THEME_GREEN2="#88c0d0"
    export THEME_CYAN="#88c0d0"
    export THEME_BLUE="#5e81ac"
    export THEME_BLUE0="#5e81ac"
    export THEME_BLUE1="#81a1c1"
    export THEME_BLUE2="#88c0d0"
    export THEME_BLUE5="#81a1c1"
    export THEME_BLUE6="#8fbcbb"
    export THEME_MAGENTA="#b48ead"
    export THEME_MAGENTA2="#b48ead"
    export THEME_PURPLE="#b48ead"

    export THEME_TERMINAL_BLACK="#3b4252"

    export NVIM_THEME="nord"
    export STARSHIP_PALETTE="nord"

# ============================================================================
# ONEDARK PALETTE
# ============================================================================
elif [[ "$COLORSCHEME" == "onedark" ]]; then
    export THEME_BG="#282c34"
    export THEME_BG_DARK="#21252b"
    export THEME_BG_HIGHLIGHT="#2c313c"
    export THEME_FG="#abb2bf"
    export THEME_FG_DARK="#5c6370"
    export THEME_FG_GUTTER="#4b5263"
    export THEME_COMMENT="#5c6370"
    export THEME_DARK3="#3e4451"
    export THEME_DARK5="#528bff"

    export THEME_RED="#e06c75"
    export THEME_RED1="#be5046"
    export THEME_ORANGE="#d19a66"
    export THEME_YELLOW="#e5c07b"
    export THEME_GREEN="#98c379"
    export THEME_GREEN1="#56b6c2"
    export THEME_GREEN2="#56b6c2"
    export THEME_CYAN="#56b6c2"
    export THEME_BLUE="#61afef"
    export THEME_BLUE0="#528bff"
    export THEME_BLUE1="#61afef"
    export THEME_BLUE2="#56b6c2"
    export THEME_BLUE5="#61afef"
    export THEME_BLUE6="#c678dd"
    export THEME_MAGENTA="#c678dd"
    export THEME_MAGENTA2="#c678dd"
    export THEME_PURPLE="#c678dd"

    export THEME_TERMINAL_BLACK="#3e4451"

    export NVIM_THEME="onedark"
    export STARSHIP_PALETTE="onedark"

# ============================================================================
# KANAGAWA WAVE PALETTE (dark, blue-ish)
# ============================================================================
elif [[ "$COLORSCHEME" == "kanagawa-wave" ]]; then
    export THEME_BG="#1F1F28"
    export THEME_BG_DARK="#181820"
    export THEME_BG_HIGHLIGHT="#2A2A37"
    export THEME_FG="#DCD7BA"
    export THEME_FG_DARK="#C8C093"
    export THEME_FG_GUTTER="#2A2A37"
    export THEME_COMMENT="#727169"
    export THEME_DARK3="#363646"
    export THEME_DARK5="#54546D"

    export THEME_RED="#C34043"
    export THEME_RED1="#E46876"
    export THEME_ORANGE="#FFA066"
    export THEME_YELLOW="#E6C384"
    export THEME_GREEN="#98BB6C"
    export THEME_GREEN1="#6A9589"
    export THEME_GREEN2="#7AA89F"
    export THEME_CYAN="#7FB4CA"
    export THEME_BLUE="#7E9CD8"
    export THEME_BLUE0="#223249"
    export THEME_BLUE1="#A3D4D5"
    export THEME_BLUE2="#2D4F67"
    export THEME_BLUE5="#9CABCA"
    export THEME_BLUE6="#658594"
    export THEME_MAGENTA="#957FB8"
    export THEME_MAGENTA2="#D27E99"
    export THEME_PURPLE="#957FB8"

    export THEME_TERMINAL_BLACK="#2A2A37"

    export NVIM_THEME="kanagawa-wave"
    export STARSHIP_PALETTE="kanagawa_wave"

# ============================================================================
# KANAGAWA DRAGON PALETTE (dark, warmer)
# ============================================================================
elif [[ "$COLORSCHEME" == "kanagawa-dragon" ]]; then
    export THEME_BG="#181616"
    export THEME_BG_DARK="#12120f"
    export THEME_BG_HIGHLIGHT="#282727"
    export THEME_FG="#c5c9c5"
    export THEME_FG_DARK="#C8C093"
    export THEME_FG_GUTTER="#282727"
    export THEME_COMMENT="#737c73"
    export THEME_DARK3="#393836"
    export THEME_DARK5="#625e5a"

    export THEME_RED="#c4746e"
    export THEME_RED1="#E46876"
    export THEME_ORANGE="#b6927b"
    export THEME_YELLOW="#c4b28a"
    export THEME_GREEN="#87a987"
    export THEME_GREEN1="#8ea4a2"
    export THEME_GREEN2="#8a9a7b"
    export THEME_CYAN="#949fb5"
    export THEME_BLUE="#8ba4b0"
    export THEME_BLUE0="#223249"
    export THEME_BLUE1="#8992a7"
    export THEME_BLUE2="#2D4F67"
    export THEME_BLUE5="#949fb5"
    export THEME_BLUE6="#658594"
    export THEME_MAGENTA="#8992a7"
    export THEME_MAGENTA2="#a292a3"
    export THEME_PURPLE="#8992a7"

    export THEME_TERMINAL_BLACK="#282727"

    export NVIM_THEME="kanagawa-dragon"
    export STARSHIP_PALETTE="kanagawa_dragon"

# ============================================================================
# KANAGAWA LOTUS PALETTE (light)
# ============================================================================
elif [[ "$COLORSCHEME" == "kanagawa-lotus" ]]; then
    export THEME_BG="#f2ecbc"
    export THEME_BG_DARK="#dcd5ac"
    export THEME_BG_HIGHLIGHT="#e7dba0"
    export THEME_FG="#545464"
    export THEME_FG_DARK="#43436c"
    export THEME_FG_GUTTER="#e7dba0"
    export THEME_COMMENT="#8a8980"
    export THEME_DARK3="#e4d794"
    export THEME_DARK5="#716e61"

    export THEME_RED="#c84053"
    export THEME_RED1="#d7474b"
    export THEME_ORANGE="#cc6d00"
    export THEME_YELLOW="#de9800"
    export THEME_GREEN="#6f894e"
    export THEME_GREEN1="#597b75"
    export THEME_GREEN2="#5e857a"
    export THEME_CYAN="#4e8ca2"
    export THEME_BLUE="#4d699b"
    export THEME_BLUE0="#c7d7e0"
    export THEME_BLUE1="#9fb5c9"
    export THEME_BLUE2="#b5cbd2"
    export THEME_BLUE5="#6693bf"
    export THEME_BLUE6="#5a7785"
    export THEME_MAGENTA="#624c83"
    export THEME_MAGENTA2="#b35b79"
    export THEME_PURPLE="#766b90"

    export THEME_TERMINAL_BLACK="#c9cbd1"

    export NVIM_THEME="kanagawa-lotus"
    export STARSHIP_PALETTE="kanagawa_lotus"

else
    echo "Warning: Unknown colorscheme '$COLORSCHEME'. Defaulting to tokyonight-storm."
    export COLORSCHEME="tokyonight-storm"
    # Recursively source to load tokyonight-storm
    source "${BASH_SOURCE[0]}"
fi
