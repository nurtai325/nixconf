{ pkgs, lib, ...}:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_opacity = "0.5";
      cursor_shape = "block";
      allow_remote_control = true;
      shell_integration = "no-cursor";
      cursor_shape_blink = false;
      ignore_os_cursor_shape = true;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 9;
    };
  };
}
