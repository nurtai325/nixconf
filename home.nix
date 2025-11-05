{ config, pkgs, ... }:

{
  imports = [
    ./nvim
    ./zsh
  ];

  home.username = "nurtai";
  home.homeDirectory = "/home/nurtai";

  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings.user.name = "nurtai325";
    settings.user.email = "nurtay.tolymbek@netcracker.com";
  };

  home.packages = [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
