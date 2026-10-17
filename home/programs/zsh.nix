{
   programs.zsh = {
      enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";

      autosuggestion = {
         enable = true;
         highlight = "fg=#6c7086";
         strategy = [ "history" "completion" ];
      };
      syntaxHighlighting.enable = true;
      history = {
         size = 50000;
         save = 50000;
         append = true;
         extended = true;
         expireDuplicatesFirst = true;
         findNoDups = true;
         ignoreAllDups = true;
         ignoreSpace = true;
         share = false;
      };
      shellAliases = {
         ll = "ls -lah";
         gs = "git status";
         tree = "eza --tree --icons -a";
      };
      initContent = ''
         if [[ -o interactive ]] \
         && [[ "''${TERM_PROGRAM:-}" == "ghostty" || "''${TERM:-}" == "xterm-ghostty" ]] \
         && [[ -z "''${TMUX:-}" && -z "''${NOTOXUS_FASTFETCH_SHOWN:-}" ]] \
         && (( $+commands[fastfetch] )); then
            export NOTOXUS_FASTFETCH_SHOWN=1
            fastfetch --config "''${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/autostart-config.jsonc"
         fi
      '';
   };
}
