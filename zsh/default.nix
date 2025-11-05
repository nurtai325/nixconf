{ pkgs, lib, ...}:

{
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
    initExtraBeforeCompInit = "bindkey -e";
    initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme; source ~/.p10k.zsh;";
  };
}
