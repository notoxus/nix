{ pkgs, ... }:

{
  programs.eclipse = {
    enable = true;
    package = pkgs.eclipses.eclipse-java;

    enableLombok = false;

    jvmArgs = [ ];
    plugins = [ ];
  };
}
