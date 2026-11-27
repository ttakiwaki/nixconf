{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/nixconf/dotfiles";
in
{
  imports = [
    ../../modules/macpkgs.nix
    ../../modules/generalpkgs.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.11";

  xdg.configFile = {
    # Configuration Directories
    "kitty".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/kitty";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/btop";
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/fastfetch";
    "sketchybar".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/mac_specific/sketchybar";
    "borders".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/mac_specific/borders";
    "yazi".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/yazi";
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
    "zed".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/zed";
    "kwall".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/kwall";
  };
  home.file = {
    # Individual Files
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.zshrc";
  };

  programs.home-manager.enable = true;
}
