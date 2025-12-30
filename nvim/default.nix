{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file.".clang-format".text = ''
    BasedOnStyle: LLVM
    IndentWidth: 4
    TabWidth: 4
    UseTab: Never
  '';

  home.file.".config/clangd/config.yaml".text =
    let
      gcc = pkgs.gcc.cc;
      gccVersion = pkgs.gcc.cc.version;
    in
    ''
      CompileFlags:
        Add:
          - "-isystem"
          - "${gcc}/include/c++/${gccVersion}"
          - "-isystem"
          - "${gcc}/include/c++/${gccVersion}/x86_64-unknown-linux-gnu"
          - "-isystem"
          - "${gcc}/include/c++/${gccVersion}/backward"
          - "-isystem"
          - "${gcc}/lib/gcc/x86_64-unknown-linux-gnu/${gccVersion}/include"
          - "-isystem"
          - "${gcc}/include"
          - "-isystem"
          - "${gcc}/lib/gcc/x86_64-unknown-linux-gnu/${gccVersion}/include-fixed"
          - "-isystem"
          - "${pkgs.glibc.dev}/include"
    '';

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfigLua = ''
      vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
          vim.highlight.on_yank()
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
              end,
            })
          end
        end,
      })
    '';

    globals = {
      mapleader = " ";
      have_nerd_font = true;
      omni_sql_no_default_maps = true;
    };

    opts = {
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

    keymaps = [
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

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
      settings.transparent = true;
    };

    plugins = {
      lualine.enable = true;
      undotree.enable = true;
      indent-blankline.enable = true;
      autoclose.enable = true;
      blame.enable = true;
      comment.enable = true;
      mini-ai.enable = true;
      mini-surround.enable = true;
      mini-statusline.enable = true;
      telescope = {
        enable = true;
        settings = {
          pickers.find_files.hidden = true;
        };
        extensions."fzf-native" = {
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
        highlight.enable = true;
        indent.enable = true;
        nixvimInjections = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          c
          cpp
          lua
          vim
          vimdoc
          bash
          python
          javascript
          typescript
          tsx
          json
          html
          css
          markdown
          markdown_inline
          nix
          rust
          go
          yaml
          toml
        ];
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          ts_ls.enable = true;
          jsonls.enable = true;
          nil_ls.enable = true;
          gopls.enable = true;
          gopls.autostart = true;
          pylsp.enable = true;
          rust-analyzer.enable = true;
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
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
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

    extraPlugins = [
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
  };
}
