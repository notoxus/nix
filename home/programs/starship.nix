{
   programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
         add_newline = false;
         command_timeout = 3000;

         character = {
            success_symbol = "[❯](bold #9ece6a)";
            error_symbol = "[❯](bold #f7768e)";
            vimcmd_symbol = "[❮](bold #7aa2f7)";
          };

         directory = {
            style = "bold #7aa2f7";
            truncation_length = 4;
            truncate_to_repo = true;
            read_only = " 󰌾";
         };

         git_branch = {
            symbol = " ";
            style = "bold #bb9af7";
         };

         git_status.style = "bold #e0af68";

         cmd_duration = {
            min_time = 2000;
            format = "took [$duration](bold #ff9e64) ";
         };

         status = {
            disabled = true;
            format = "[$symbol$status](bold #f7768e) ";
         };

         line_break.disabled = false;
     };
   };
}
