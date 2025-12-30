{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    {
      mode = "i";
      key = "<tab>";
      action = "    ";
    }
    {
      mode = "n";
      key = "<leader>ve";
      action.__raw = "vim.cmd.Ex";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>!tmux new-window sd<cr>";
    }
    {
      mode = "n";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "v";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }
    {
      mode = "n";
      key = "[d";
      action.__raw = "vim.diagnostic.goto_prev";
    }
    {
      mode = "n";
      key = "]d";
      action.__raw = "vim.diagnostic.goto_next";
    }
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "vim.diagnostic.open_float";
    }
    {
      mode = "n";
      key = "<leader>q";
      action.__raw = "vim.diagnostic.setloclist";
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
    }

    {
      mode = "n";
      key = "<leader>sf";
      action = "<cmd>Telescope find_files<CR>";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action = "<cmd>Telescope live_grep<CR>";
    }
    {
      mode = "n";
      key = "<leader>sc";
      action = "<cmd>Telescope commands<CR>";
    }

    {
      mode = "n";
      key = "gD";
      action = "<cmd>Telescope lsp_definitions<CR>";
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>Telescope lsp_references<CR>";
    }
    {
      mode = "n";
      key = "gi";
      action = "<cmd>Telescope lsp_implementations<CR>";
    }
    {
      mode = "n";
      key = "<leader>D";
      action = "<cmd>Telescope lsp_type_definitions<CR>";
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = "<cmd>Telescope lsp_document_symbols<CR>";
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
    }
    {
      mode = "n";
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
    }
    {
      mode = "n";
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
    }
    {
      mode = "n";
      key = "gh";
      action = "<cmd>lua vim.lsp.buf.highlight()<CR>";
    }
  ];
}
