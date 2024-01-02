local lspconfig = require('lspconfig')
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local utils = require("utils")
lspconfig.tsserver.setup {}
-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local map = function(mode, l, r, opts)
  opts = opts or {}
  opts.silent = true
  opts.buffer = bufnr
  keymap.set(mode, l, r, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions  
    map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
    map("n", "<C-]>", vim.lsp.buf.definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
    map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
    map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
    map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
    -- this puts diagnostics from opened files to quickfix
    map("n", "<space>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })
    -- this puts diagnostics from current buffer to quickfix
    map("n", "<space>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
    map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
    map("n", "<space>wl", function()
      inspect(vim.lsp.buf.list_workspace_folders())
    end, { desc = "list workspace folder" })
  
    -- Set some key bindings conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
      map("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })
    end
  end,

})
