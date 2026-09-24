{ lib, ... }:

{
  imports = [
    ./home/programs
    ./home/desktop
    ./home/packages.nix
  ];
  home.username = "juo";
  home.homeDirectory = "/home/juo";

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}

