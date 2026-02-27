{
  config,
  pkgs,
  lib,
  unstable,
  ...
}:

{
  programs.nixvim.extraConfigLua = ''
    vim.env.PATH = "${unstable.go_1_26}/bin:" .. vim.env.PATH
    vim.g.go_highlight_functions = 0
    vim.g.go_highlight_methods = 0

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
    -- Force Go files to use treesitter
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'go',
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Ensure Go highlighting is enabled
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*.go',
      callback = function()
        if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
          vim.treesitter.start()
        end
      end,
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        vim.diagnostic.enable()
      end
    })
  '';
}
