typeset -U path PATH

path=(
    "$HOME/.local/bin:$PATH"
    "$HOME/go/bin"
    $path
)
export PATH

# Environment
export EDITOR="nvim"
export VISUAL="nvim"
export WALLPAPER_DIR="$HOME/Downloads/Wallpaper"

# Yazi Open Command
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# OS-Specific Commands
if [[ "$OSTYPE" == "darwin"* ]]; then
    function start-hyprland() {
      pgrep -x borders >/dev/null || nohup borders >/dev/null 2>&1 &
      pgrep -x sketchybar >/dev/null || nohup sketchybar >/dev/null 2>&1 &
    }

    function kill-hyprland() {
      pkill -x borders
      pkill -x sketchybar
    }

    alias poweroff="osascript -e 'tell app \"System Events\" to shut down'"

    # Nix Aliases
    alias ngc="nix-collect-garbage -d"
    alias nrs="home-manager switch --flake ~/nixconf#macos --impure"
fi

# Zsh Configurations
PROMPT="%F{5}%n%f@%F{2}%M%f %F{6}%~%f> "
source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
