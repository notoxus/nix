{ pkgs, ... }:

{
  # Noctalia's battery / power information
  services.upower.enable = true;

  # Power performance mode
  services.power-profiles-daemon.enable = true;

  # Lid behavior
  services.logind.settings.Login = {
    # On battery: closing and suspending
    HandleLidSwitch = "suspend";
    # On AC: keep the machine running by this way:
    # Lock + monitor-off will be handled separately in the user session.
    HandleLidSwitchExternalPower = "ignore";
    # External monitor / dock: keep running.
    HandleLidSwitchDocked = "ignore";
  };

  # Lenovo Conservation Mode.
  systemd.services.lenovo-conservation-mode = {
    description = "Enable Conservation Mode";

    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      path="/sys/bus/platform/devices/VPC2004:00/conservation_mode"

      if [ -w "$path" ]; then
        echo 1 > "$path"
      else
        echo "Lenovo conservation_mode interface not found: $path" >&2
      fi
    '';
  };
}
