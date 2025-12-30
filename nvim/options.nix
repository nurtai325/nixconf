{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.nixvim.opts = {
    guicursor = "a:block";
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    updatetime = 50;
    colorcolumn = "80";
    termguicolors = true;
    wrap = false;
    swapfile = false;
    backup = false;
    undodir = "${config.home.homeDirectory}/.vim/undodir";
    undofile = true;
    incsearch = true;
    hlsearch = true;
    number = true;
    relativenumber = true;
    mouse = "a";
    showmode = false;
    breakindent = true;
    ignorecase = true;
    smartcase = true;
    signcolumn = "yes";
    splitright = true;
    splitbelow = true;
    list = true;
    listchars = {
      tab = "| ";
      trail = "·";
      nbsp = "␣";
    };
    inccommand = "split";
    cursorline = true;
    scrolloff = 10;
  };
}
