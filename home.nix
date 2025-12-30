{ config, pkgs, ... }:

{
  imports = [
    ./nvim
    ./zsh
    ./tmux
  ];

  home.username = "nurtai";
  home.homeDirectory = "/home/nurtai";

  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings.user.name = "nurtai325";
    settings.user.email = "nurtolymbek23@gmail.com";
  };

  home.packages = [
    pkgs.zsh-powerlevel10k
    pkgs.tree-sitter
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.gnumake
    pkgs.gcc
    pkgs.go
    pkgs.zip
    pkgs.unzip
    pkgs.clang-tools
    pkgs.istioctl
    pkgs.kind
    pkgs.kubectl
    pkgs.rustc
    pkgs.python312
    pkgs.bat
    pkgs.lm_sensors

    (pkgs.writeShellScriptBin "sd" (builtins.readFile ./zsh/sd.sh))
  ];

  home.file = {
    ".p10k.zsh".source = ./zsh/p10k.zsh;
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files";
    defaultOptions = [
      "--height 80%"
      "--layout=reverse"
      "--border"
    ];
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_opacity = "0.75";
      cursor_shape = "block";
      allow_remote_control = true;
      shell_integration = "no-cursor";
      cursor_shape_blink = false;
      ignore_os_cursor_shape = true;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 8.4;
    };
  };
}
