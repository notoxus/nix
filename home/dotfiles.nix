{ config, lib, inputs, ... }:

let
  cfg = config.my.dotfiles;
  pick = component: rel:
    if builtins.elem component cfg.live
    then config.lib.file.mkOutOfStoreSymlink "${cfg.path}/${component}/${rel}"
    else "${inputs.dotfiles}/${component}/${rel}";

  configDirs = [ "ghostty" "niri" "noctalia" "nvim" "tmux" "fastfetch" "btop" "yazi" "zsh" ];
  pluginDir = ".local/share/noctalia/plugins";
  plugins = builtins.attrNames (builtins.readDir "${inputs.dotfiles}/noctalia/${pluginDir}");
in
{
  options.my.dotfiles = {
    path = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/dotfiles";
      description = "Checkout used for live (out-of-store) links.";
    };
    live = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "noctalia" "nvim" "tmux" "zsh" ];
      description = "Components that write into their own config dir at runtime.";
    };
  };

  config = {
    xdg.configFile =
      lib.genAttrs configDirs (c: { source = pick c ".config/${c}"; })
      // { "starship.toml".source = pick "starship" ".config/starship.toml"; };

    # Link plugins one by one so community plugins installed from the
    # Noctalia UI don't end up inside your git checkout.
    xdg.dataFile = lib.genAttrs (map (p: "noctalia/plugins/${p}") plugins)
      (n: { source = pick "noctalia" ".local/share/${n}"; });

    home.file.".zshenv".text = ''export ZDOTDIR="$HOME/.config/zsh"'';
  };
}
