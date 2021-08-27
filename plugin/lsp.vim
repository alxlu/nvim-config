set completeopt=menuone,noinsert,noselect

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap gr :Lspsaga rename<CR>
nnoremap gR :Lspsaga lsp_finder<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
--local on_attach = require'completion'.on_attach 
require'lspconfig'.vimls.setup{}
--[[
require'lspconfig'.tsserver.setup{ 
  --cmd = {"typescript-language-server",  "--stdio", "--tsserver-path=/ur/local/bin/tsserver", "--tsserver-log-file=/tmp/ts-logs.txt"},
  cmd = {"/home/alex/.npm-global/bin/typescript-language-server",  "--stdio", "--tsserver-log-file=/tmp/ts-logs.txt"},
  on_attach=on_attach
}
]]--
local coq = require "coq"
require'lspconfig'.tsserver.setup(coq.lsp_ensure_capabilities{
  cmd = {"/home/alex/.npm-global/bin/typescript-language-server",  "--stdio", "--tsserver-log-file=/tmp/ts-logs.txt"},
})

require'lspconfig'.gopls.setup(coq.lsp_ensure_capabilities{
  cmd = {"/home/alex/go/bin/gopls"}
})

local sumneko_root_path = '/home/alex/.local/src/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

-- vim.lsp.set_log_level("debug")
local saga = require 'lspsaga'
saga.init_lsp_saga {
  rename_action_keys = {
    quit = '<Esc>', exec = '<CR>'
  },
  finder_action_keys = {
    quit = '<Esc>', open = '<CR>', scroll_down = '<Down>', scroll_up = '<Up>'
  },
  max_preview_lines = 30
}
EOF
