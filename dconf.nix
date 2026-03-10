# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file://${./wallpaper.png}";
      picture-uri-dark = "file://${./wallpaper.png}";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      maximize = [ "<Super>Up" ];
      switch-to-workspace-1 = [ "<Alt>1" ];
      switch-to-workspace-2 = [ "<Alt>2" ];
      switch-to-workspace-3 = [ "<Alt>3" ];
      switch-to-workspace-4 = [ "<Alt>4" ];
      unmaximize = [ "<Super>Down" "<Alt>F5" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      www = [ "<Alt>f" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>t";
      command = "kitty";
      name = "Launch terminal";
    };
  };
}
