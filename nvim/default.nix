{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./autocmds.nix
    ./options.nix
    ./keymaps.nix
    ./plugins.nix
    ./clangd.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals = {
      mapleader = " ";
      have_nerd_font = true;
      omni_sql_no_default_maps = true;
    };

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
      settings.transparent = true;
    };
  };
}
