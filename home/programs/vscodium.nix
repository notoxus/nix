{ pkgs, ... }:

{
   programs.vscodium = {
      enable = true;

      profiles.default = {
         extensions = with pkgs.vscode-extensions; [
            # Nix
            bbenoist.nix
            arrterian.nix-env-selector
            # C/C++
            llvm-vs-code-extensions.vscode-clangd
            # C#
            ms-dotnettools.csharp
            # Java
            redhat.java
            # Python
            ms-python.python

            formulahendry.code-runner
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
