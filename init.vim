let mapleader=" "

"vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'glacambre/firenvim', { 'do': function('firenvim#install') }

Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" TypeScript
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo'}
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

call plug#end()

"Disable ex and command history modes
nnoremap q: <Nop>
vnoremap q: <Nop>
nnoremap Q <Nop>
vnoremap Q <Nop>

nnoremap QQ <cmd>quitall!<CR>
vnoremap QQ <cmd>quitall!<CR>

"Turn off compatability mode
set nocompatible

let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.8} }
let $FZF_DEFAULT_COMMAND = 'fd -HL -t f -t l'
let g:fzf_buffers_jump = 1

nnoremap <leader>D :cd %:p:h<CR>

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>d :Commands<CR>
nnoremap <leader>lb :BLines<CR>
nnoremap <leader>l :Lines<CR>
" autocmd BufRead,BufNewFile *.md :Goyo
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
" autocmd BufRead,BufNewFile *.md s:goyo_enter()
nnoremap <leader>g  :Goyo<CR>

nnoremap <leader>ll :Limelight!!<CR>

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

set relativenumber
filetype plugin on
filetype plugin indent on
syntax on

nnoremap <leader>t  :NERDTreeToggle<CR>
nnoremap <leader>n  :NERDTreeFind<CR>

"bind nohl
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Shows current typed command
set showcmd

"Set autoindentt
set autoindent

"Tab completion
set wildmenu
set wildmode=list:longest,full

"Optimize for fast terminal connections
set ttyfast

"Enable mouse support
set mouse=a

"Show line numbers
set number

"Don't add empty newlines at end of files
"set binary
"set noeol

"Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

"Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

"Hide modified buffers
set hidden

"Status line information
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

"Syntax highlighting
filetype plugin indent on
syntax on
set background=dark

"Color scheme
" colorscheme seoul256
" colorscheme gotham
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE


"Highlight current line
set cul

"Set tabs
set expandtab
"set tabstop=2
set shiftwidth=2
set softtabstop=2

"Ignore case of searches
set ignorecase

"Highlight dynamically as pattern is typed
set incsearch

"Show invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:␣
set list

" Show the cursor position
set ruler

"Show the current mode
set showmode

"Show the (partial) command as it's being typed
set showcmd

"Allow deleting previous items and indents
set backspace=indent,eol,start

"Find path settings
set path=$PWD/**

"Key remaps
nnoremap <C-Q> <C-L>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Change split behavior
set splitbelow
set splitright

"ignore certain directories and files
set wildignore+=*/node_modules/*,*/.git/*,*/tmp/*,*.so,*.swp,*.zip

"js syntax
":autocmd Syntax * call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'NonText')
":autocmd Syntax * call SyntaxRange#Include('@begin=bash@', '@end=bash@', 'sh', 'NonText')

"orgmode agenda
"let g:org_agenda_files = ['~/Dropbox/orgmode/*.org']

"vimwiki
let wiki_1 = {}
let wiki_1.path = '/mnt/data/wikis/personal'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = '/mnt/data/wikis/development'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2]

let g:ctrlp_show_hidden = 1

noremap <silent> <m-h> :TmuxNavigateLeft<cr>
noremap <silent> <m-j> :TmuxNavigateDown<cr>
noremap <silent> <m-k> :TmuxNavigateUp<cr>
noremap <silent> <m-l> :TmuxNavigateRight<cr>


"TypeScript stuff
" coc config
set updatetime=300
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" confirm completion with Enter
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>f  :CocCommand prettier.formatFile<CR>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

