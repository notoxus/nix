{ pkgs, ... }:

{
   programs.vscodium = {
      enable = true;

      profiles.default = {
         extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            formulahendry.code-runner
            arrterian.nix-env-selector
            dracula-theme.theme-dracula
         ];

         userSettings = {
            "workbench.colorTheme" = "Dracula Theme";

            "code-runner.clearPreviousOutput" = true;
            "code-runner.saveFileBeforeRun" = true;

            "editor.fontSize" = 16;
            "files.autoSave" = "afterDelay";
            "files.autoSaveDelay" = 500;
         };
      };
   };
}
