{ pkgs, ... }:

let
  soundcore-control = pkgs.appimageTools.wrapType2 rec {
    pname = "soundcore-control";
    version = "0.3.1";

    src = pkgs.fetchurl {
      url = "https://github.com/d7omdev/soundcore-control/releases/download/v${version}/Soundcore-Control-v${version}-x86_64.AppImage";
      hash = "sha256-vNQLKu/bTgDNP8newVBLo3+IDpHsgcxN9gEFoSFMsLQ=";
    };

    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract {
          inherit pname version src;
        };
      in
      ''
        install -m 444 -D \
          ${contents}/usr/share/applications/soundcore-control.desktop \
          $out/share/applications/soundcore-control.desktop

        install -m 444 -D \
          ${contents}/usr/share/icons/hicolor/512x512/apps/soundcore-control.png \
          $out/share/icons/hicolor/512x512/apps/soundcore-control.png
      '';
  };
in
{
  home.packages = [
    soundcore-control
  ];

  systemd.user.services.soundcore-control-watch = {
    Unit = {
      Description = "Soundcore Control Bluetooth connection watcher";
      After = [
        "bluetooth.target"
        "dbus.socket"
      ];
      Requires = [ "dbus.socket" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${soundcore-control}/bin/soundcore-control --watch";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
