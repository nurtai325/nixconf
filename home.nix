{
  pkgs,
  ...
}:

let
  sdScript = (
    pkgs.writeShellScriptBin "sd" ''
      selected=$(find "$HOME" -maxdepth 2 -type d,l | rg -v '\/\.[^/]+' | fzf)
      [ -z "$selected" ] && exit 0
      name=$(basename "$selected" | tr . _)
      tmux has-session -t "$name" 2>/dev/null || tmux new-session -s "$name" -c "$selected" -d
      tmux switch-client -t "$name" || tmux a -t "$name"
    ''
  );
in
{
  imports = [
    ./zsh.nix
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
    pkgs.go_1_26
    pkgs.gopls
    pkgs.zip
    pkgs.unzip
    pkgs.clang
    pkgs.python312
    pkgs.bat
    pkgs.rustup
    pkgs.zed-editor
    pkgs.vulkan-tools

    sdScript
  ];

  home.file = {
    ".p10k.zsh".source = ./p10k.zsh;
    ".curlrc".text = ''
      max-time = 72000
      connect-timeout = 72000
    '';
    ".clang-format".text = ''
      BasedOnStyle: LLVM
      IndentWidth: 4
      TabWidth: 4
    '';
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
