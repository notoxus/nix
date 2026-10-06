{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      diff.algorithm = "histogram";
      merge.conflictStyle = "zdiff3";
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      "*.swo"
      ".direnv/"
      "result"
      "result-*"
    ];
  };
}
