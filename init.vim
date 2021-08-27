let mapleader=" "

"vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'christoomey/vim-tmux-navigator'
Plug 'szw/vim-maximizer'
Plug 'puremourning/vimspector'
" Plug 'glacambre/firenvim', { 'do': function('firenvim#install') }

Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'tpope/vim-commentary'

" TypeScript
" Plug 'neoclide/coc.nvim', { 'branch': 'release', 'for': ['typescript', 'javascript', 'javascriptreact'] }
" Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'javascript'] }
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'glepnir/lspsaga.nvim'


" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

"FZF until https://github.com/nvim-telescope/telescope.nvim/issues/392 is fixed
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Markdown
Plug 'junegunn/goyo.vim', { 'on': 'Goyo'}
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

" formatter
Plug 'sbdchd/neoformat'

" linting
Plug 'dense-analysis/ale'

call plug#end()


lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.8} }
let $FZF_DEFAULT_COMMAND = 'fd -HL -t f -t l'
let g:fzf_buffers_jump = 1
nnoremap <leader>ps :Rg<CR>

"Add local node_modules to bin
if isdirectory($PWD .'/node_modules')
    let $PATH .= ':' . $PWD . '/node_modules/.bin'
endif

"Disable ex and command history modes
nnoremap q: <Nop>
vnoremap q: <Nop>
nnoremap Q <Nop>
vnoremap Q <Nop>

nnoremap QQ <cmd>quitall!<CR>
vnoremap QQ <cmd>quitall!<CR>
nnoremap WW <cmd>quit!<CR>
vnoremap WW <cmd>quit!<CR>

"Turn off compatability mode
set nocompatible

nnoremap <leader>D :cd %:p:h<CR>

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
nnoremap <leader>gg  :Goyo<CR>

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

"Change split behavior
set splitbelow
set splitright

"ignore certain directories and files
set wildignore+=*/node_modules/*,*/.git/*,*/tmp/*,*.so,*.swp,*.zip

"js syntax
":autocmd Syntax * call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'NonText')
":autocmd Syntax * call SyntaxRange#Include('@begin=bash@', '@end=bash@', 'sh', 'NonText')

"vimwiki
let wiki_1 = {}
let wiki_1.path = '/mnt/data/homes/default/wikis/personal'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = '/mnt/data/homes/default/wikis/development'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let wiki_3 = {}
let wiki_3.path = '/mnt/data/homes/default/wikis/work'
let wiki_3.syntax = 'markdown'
let wiki_3.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]

let g:ctrlp_show_hidden = 1

let g:tmux_navigator_no_mappings = 1
noremap <silent> <m-h> :TmuxNavigateLeft<cr>
noremap <silent> <m-j> :TmuxNavigateDown<cr>
noremap <silent> <m-k> :TmuxNavigateUp<cr>
noremap <silent> <m-l> :TmuxNavigateRight<cr>
noremap <silent> <m-\> :TmuxNavigatePrevious<cr>

nnoremap <silent> <C-j> :res +5<cr>
nnoremap <silent> <C-k> :res -5<cr>
nnoremap <silent> <C-h> :vertical resize -5<cr>
nnoremap <silent> <C-l> :vertical resize +5<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

vnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

tnoremap <C-n> <C-\><C-n>
tnoremap <silent> <m-h> <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <m-j> <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <m-k> <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <m-l> <C-\><C-n>:TmuxNavigateRight<cr>

nnoremap <leader>o :MaximizerToggle<CR>
vnoremap <leader>o :MaximizerToggle<CR>gv

nnoremap <leader>u :UndotreeToggle<CR>
vnoremap <leader>u :UndotreeToggle<CR>gv

nnoremap <leader>gj :diffget //3<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gp :diffput<CR>

nnoremap <leader>f :Neoformat<CR>

nnoremap <leader>e :split<CR>:term<CR>i
