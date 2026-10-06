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
   };
}
