{ pkgs, inputs, ... }:

let
   system = pkgs.stdenv.hostPlatform.system;
   unstable = import inputs.nixpkgs {
    inherit system;

    config.allowUnfreePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "cisco-packet-tracer"
        "CiscoPacketTracer_901_Ubuntu_64bit.deb"
      ];
  };  
in
{
  home.packages = with pkgs; [
    # CLI / terminal
    tmux
    neovim
    fastfetch
    eza
    lazygit
    bat
    delta
    dust
    btop
    ripgrep
    gh
    file
    imagemagick
    # Networking & Troubleshooting
    nmap
    avahi
    # Development
    jdk21
    nodejs
    pnpm
    python3
    cargo
    clang
    clang-tools
    dotnet-sdk
    docker
    # Lab setting up
    openvpn
    # Desktop App
    thunar
    codex
    rnote
    gaphor
    unstable.rustdesk-flutter
    obs-studio
    mpv
    ardour
    libreoffice
    zotero
    unstable.cisco-packet-tracer_9
    (writeShellScriptBin "wake-usb" ''
      export PATH="${pkgs.usbutils}/bin:$PATH"
      echo "=== Scan and Reset Connected Peripheral Devs ==="
  
      # Laptop/Desktop checking
      if ls /sys/class/power_supply/BAT* 1> /dev/null 2>&1; then
        SAFE_LIST=$(lsusb | grep -i -v -E "root hub|wireless|camera|bluetooth")
      else
        SAFE_LIST=$(lsusb | grep -i -v "root hub")
      fi
  
      if [ -z "$SAFE_LIST" ]; then
        echo "Not found any valid devices"
        read -n 1 -s -r -p "Press any key to exit..."
        exit 0
      fi

      echo "$SAFE_LIST" | awk '{printf "[%d] %s\n", NR, $0}'
      echo ""
  
      read -p "Input the process number: " choice
  
      if ! [[ "$choice" =~ ^[0-9]+$ ]]; then 
        echo "Error: Invalid input!"
        sleep 2
        exit 1
      fi

      TARGET_ADDR=$(echo "$SAFE_LIST" | awk -v line="$choice" 'NR==line {print $2"/"$4}' | tr -d ':')
      TARGET_NAME=$(echo "$SAFE_LIST" | awk -v line="$choice" 'NR==line {for(i=7;i<=NF;i++) printf "%s ", $i}')
  
      if [ -n "$TARGET_ADDR" ]; then
        echo "Resetting port $TARGET_ADDR ($TARGET_NAME)..."
        sudo usbreset "$TARGET_ADDR"
        echo "Done!"
      else
        echo "Not found [$choice]."
      fi
  
      echo ""
      read -n 1 -s -r -p "Press any key to exit..."
    '')
  ];
}
