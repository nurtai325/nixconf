{ pkgs, lib, ... }:

{

  imports = [
    ./tmux.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      l = "ls --color=auto -lah";
      vimf = "nvim $(fzf)";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };
    initContent = lib.mkOrder 550 ''
      bindkey -v;
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme; source ~/.p10k.zsh;
    '';
  };
}
