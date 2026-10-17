{ config, pkgs, ... }:
{
   fonts.packages = with pkgs; [
      corefonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
   ];
   fonts.fontconfig.defaultFonts = {
      monospace = [
         "JetBrainsMono Nerd Font Mono"
         "Noto Sans Mono CJK SC"
         "Noto Color Emoji"
      ];
      sansSerif = [
         "Inter"
         "Symbols Nerd Font"
         "Noto Sans CJK SC"
         "Noto Color Emoji"
      ];
      serif = [
         "Noto Serif"
         "Noto Serif CJK SC"
         "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
   };
}
