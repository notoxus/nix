{ config, lib, pkgs, ... }:

let
  brother-dcp-t430w = import ./default.nix {
    inherit pkgs lib;
  };
in
{
  services.printing = {
    enable = true;
    drivers = [
      brother-dcp-t430w
    ];
  };
}
