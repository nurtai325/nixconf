return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true

    local parser_install_dir = vim.fn.stdpath('data') .. '/treesitter'
    vim.fn.mkdir(parser_install_dir, 'p')
    vim.opt.runtimepath:append(parser_install_dir)

    require('nvim-treesitter.configs').setup({
      parser_install_dir = parser_install_dir,
      auto_install = true,
      ensure_installed = { },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
