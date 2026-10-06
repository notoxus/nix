# NixOS System Configuration ❄️

This repository contains my declarative NixOS and Home Manager configuration.

`To see the modular structure`
[Read It](LAYOUT.md)

### System Installation
- Home Manager is integrated into the NixOS flake, so apply both system and user configurations together:

```sh
sudo nixos-rebuild switch --flake .#juosterben
```
- **(Note: Replace juosterben with your own target hostname if you modify flake.nix)**

## Desktop Applications

The NixOS Home Manager configuration includes the core applications I use daily. You can find and modify these packages in `home/packages.nix`.

## Configuration Ownership

- On this system, Home Manager completely owns Zsh and its generated files under ~/.config/zsh.

- The files in this repository contain the current machine's username, host name, hardware configuration, and package choices. Please review them carefully before applying this flake on another machine.

## Others

- `home/modules/power.nix` is my favorite power management

- `home/brother-dcp-t430w/` is my print config

```
nixpkgs-stable-firmware.url = "github:NixOS/nixpkgs/d2f0551226ee44652aebf6217752cc78f7a47e84";
```
Is my stable Radeon 680M gpu's firmware. I hope AMD corporation will fix that to the lastest commit.

- `wake-usb` command in home/packages.nix is the way I reconnect my device if I accidentally or intentionally eject them=)