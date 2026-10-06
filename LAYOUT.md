nix/
├── flake.nix
├── flake.lock
├── configuration.nix
├── hardware-configuration.nix
├── home.nix
│
├── modules/
│   ├── drivers/
│   │   ├── <driver_name>/
│   │   │   ├── <driver_name>.rpm/.deb
│   │   │   ├── module.nix
│   │   │   └── default.nix
│   │   └── ...
│   │
│   └── system/
│       ├── power.nix
│       └── ...
│
└── home/
    ├── default.nix
    ├── desktop/
    │   ├── default.nix
    │   ├── audio.nix
    │   ├── cursor.nix
    │   ├── gtk.nix
    │   ├── xdg.nix
    │   └── soundcore.nix
    │
    ├── programs/
    │   ├── default.nix
    │   ├── git.nix
    │   ├── gh.nix
    │   ├── zsh.nix
    │   ├── ghostty.nix
    │   ├── tmux.nix
    │   ├── neovim.nix
    │   ├── starship.nix
    │   ├── fzf.nix
    │   ├── yazi.nix
    │   └── vscodium.nix
    └── packages.nix