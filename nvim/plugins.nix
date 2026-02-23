{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.nixvim.plugins = {
    lualine.enable = true;
    undotree.enable = true;
    indent-blankline.enable = true;
    autoclose.enable = true;
    blame.enable = true;
    comment.enable = true;
    mini-ai.enable = true;
    mini-surround.enable = true;
    mini-statusline.enable = true;
    web-devicons.enable = true;

    telescope = {
      enable = true;
      settings = {
        pickers.find_files.hidden = true;
      };
      extensions.fzf-native = {
        enable = true;
        settings = {
          fuzzy = true;
          override_file_sorter = true;
          override_generic_sorter = true;
          case_mode = "smart_case";
        };
      };
    };

    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection.enable = true;
      };
      nixvimInjections = true;
      folding = false;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    };

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        ts_ls.enable = true; 
        jsonls.enable = true;
        nil_ls.enable = true;
        gopls = {
          enable = true;
          settings = {
            gopls = {
              semanticTokens = false;
            };
          };
        };
        pylsp.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        clangd.enable = true;
      };
    };

    lsp-format.enable = true;
    lsp-lines.enable = true;

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "__raw" = ''
            cmp.mapping.preset.insert({
              ["<C-n>"] = cmp.mapping.select_next_item(),
              ["<C-p>"] = cmp.mapping.select_prev_item(),
              ["<C-y>"] = cmp.mapping.confirm({ select = true }),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
            })
          '';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
  };

  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "my-plugin";
      src = pkgs.fetchFromGitHub {
        owner = "mtdl9";
        repo = "vim-log-highlighting";
        rev = "1037e26f3120e6a6a2c0c33b14a84336dee2a78f";
        hash = "sha256-DqYSCtndUNIZsd9zpTFBhESXw3graNrjGC3WhcZ9uTA=";
      };
    })
  ];
}
