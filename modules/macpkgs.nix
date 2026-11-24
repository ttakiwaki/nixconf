{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Applications
    sketchybar
    jankyborders
  ];
}
