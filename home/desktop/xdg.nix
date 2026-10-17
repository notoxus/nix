{
xdg = {
      enable = true;
      configFile."niri-mimeapps.list".text = ''
         [Default Applications]
         inode/directory=thunar.desktop
      '';

      configFile."kde-mimeapps.list".text = ''
         [Default Applications]
         inode/directory=org.kde.dolphin.desktop
      '';
   };
}
