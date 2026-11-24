{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Applications
    btop
    fastfetch
    yazi
    neovim

    # Tools
    nixd
    zsh-autosuggestions
    zsh-syntax-highlighting
    ffmpeg
    mpv
    fzf
    chafa
    tree
    fish
    git-lfs
    imagemagick
    jq
    mupdf
    nodejs
    tree-sitter
    ripgrep
    fd
    uv

    # Fonts
    geist-font
    jetbrains-mono
    fira-code
    nerd-fonts.symbols-only
  ];
}
