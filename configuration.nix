{ config, lib, pkgs, inputs, ... }:

{
   imports = [ 
      ./hardware-configuration.nix
      ./modules/system
      ./modules/drivers/brother-dcp-t430w/module.nix
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
   ];

   # Use the systemd-boot EFI boot loader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "juosterben";
   networking.networkmanager.enable = true;
   hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
   };
   # Set your time zone.
   time.timeZone = "Asia/Ho_Chi_Minh";
   # Configure network proxy if necessary
   # networking.proxy.default = "http://user:password@proxy:port/";
   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

   # Select internationalisation properties.
   # i18n.defaultLocale = "en_US.UTF-8";
   # console = {
   #   font = "Lat2-Terminus16";
   #   keyMap = "us";
   #   useXkbConfig = true; # use xkb.options in tty.
   # };
   i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
         qt6Packages.fcitx5-unikey
         fcitx5-gtk
      ];
   };

   # Enable the X11 windowing system.
   # services.xserver.enable = true;
   # Configure keymap in X11
   # services.xserver.xkb.layout = "us";
   # services.xserver.xkb.options = "eurosign:e,caps:escape";

   # Enable CUPS to print documents.
   services.printing.enable = true;

   # Enable sound.
   # services.pulseaudio.enable = true;
   # OR
   services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true; # JACK compatibility
   };
   # Enable touchpad support (enabled default in most desktopManager).
   # services.libinput.enable = true;
   programs.niri.enable = true;
   programs.noctalia = { 
      enable = true;
   };
   services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
         cursor = {
            theme = "Bibata-Modern-Ice";
            size = 28;
            path = "${pkgs.bibata-cursors}/share/icons";
         };

         keyboard = {
            layout = "us";
         };

         idle = {
            timeout = 300;
         };

         appearance = {
            font_family = "JetBrainsMono Nerd Font";
         };
      };
   };
   programs.thunar.enable = true;
   programs.thunar.plugins = [ pkgs.thunar-volman ];
   # Plug N Play instead of 'sudo mount' commands
   services.gvfs.enable = true;
   services.udisks2.enable = true;
   # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.juo = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "podman" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        # Cuz I used home.nix, so I dont need that block anyway
      ];
   };
   programs.zsh.enable = true;
   programs.firefox.enable = true;
   programs.appimage = {
      enable = true;
      binfmt = true;
   };
   hardware.amdgpu.initrd.enable = true;
   hardware.graphics.enable = true;
   zramSwap.enable = true;
   # List packages installed in system profile.
   # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
      vim
      wget
      git
      git-lfs
      unzip
      gcc
      gnumake
      xwayland-satellite
      pciutils
      cliphist
      wl-clipboard
      fuzzel
      rpm
      dpkg
      distrobox
      podman
   ];
   virtualisation.podman = {
      enable = true;
      dockerCompat = true; 
      defaultNetwork.settings.dns_enabled = true;
   };
   # Some programs need SUID wrappers, can be configured further or are
   # started in user sessions.
   # programs.mtr.enable = true;
   # programs.gnupg.agent = {
   #   enable = true;
   #   enableSSHSupport = true;
   # };

   # List services that you want to enable:

   # Enable the OpenSSH daemon.
   # services.openssh.enable = true;

   # Open ports in the firewall.
   # networking.firewall.allowedTCPPorts = [ ... ];
   # networking.firewall.allowedUDPPorts = [ ... ];
   # Or disable the firewall altogether.
   # networking.firewall.enable = false;

   # Copy the NixOS configuration file and link it from the resulting system
   # (/run/current-system/configuration.nix). This is useful in case you
   # accidentally delete configuration.nix.
   # system.copySystemConfiguration = true;
   nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
         "davinci-resolve"
         "brother-dcp-t430w-driver"
         "corefonts"
         "vscode-extension-ms-dotnettools-csharp"
      ];
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   system.stateVersion = "26.05";
}

