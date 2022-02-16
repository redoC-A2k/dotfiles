""""""""" General settings """"""""
" turns syntax on
syntax on
" tabs settings
set expandtab
set tabstop=2
set shiftwidth=2
" number line
set relativenumber
set number
" gives case sensitive searching
" no swapfile and no backup because I will be  creating undodir and undofile
set ignorecase smartcase
set noswapfile
set nobackup
" undofile and undodir
set undodir=~/.local/share/nvim/undodir
set undofile
" increamental search as I type
set incsearch
set nohlsearch
set laststatus=2
"wrapping
set nowrap
set nocp
set mouse=a
"add intent in new line
set autoindent
set smartindent
set completeopt=menu,menuone,noselect

"""""""""""""""""""""PATHS"""""""""""""""""""""
set path+=~/College/SEM-4/**
set path+=~/College/SEM-5/**

"""""""""""""""VIM-PLUG""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-peekaboo'
Plug 'chrisbra/colorizer'
Plug 'cohama/lexima.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'dylanaraps/wal.vim'
Plug 'arrufat/vala.vim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ryanoasis/vim-devicons'
call plug#end()

""""""""""""wal colorscheme"""""""""
colorscheme wal
"""""""""""""""Vundle"""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.local/share/nvim/bundle/Vundle.vim
call vundle#begin('~/.local/share/nvim/bundle/')

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Yggdroot/indentLine'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-unimpaired'

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

""""""""""""indentLine""""""""""""
" let g:indentLine_char = '┊'
let g:indentLine_char_list = ['▏', '┆', '┊']
let g:indentLine_color_term = 250

"""""""""""" colorizer """"""""""""""""
:let g:colorizer_auto_filetype='sass,scss,css,html'

"""""""""""""" render italics """"""""""""""
highlight Comment cterm=italic

""""""""""""ultisnips""""""""""""
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

""""""""""nvim-compe""""""""""
" NOTE: Order is important. You can't lazy loading lexima.vim.
"let g:lexima_no_default_rules = v:true
"call lexima#set_default_rules()
"inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
"highlight link CompeDocumentation NormalFloat

""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""Custom key bindings"""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-I> i <ESC>r
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap te :tabedit<Space>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>
nnoremap tk :tabnext <CR>
nnoremap tj :tabprevious <CR>

"""""Nerdtree""""
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"""""""""""""Load init.lua"""""""""""""
lua require("lsp")

""""""""for nvim-jdtls """"""""""""
" if has('nvim-0.5')
  " "packadd nvim-jdtls
  " lua jdtls = require('jdtls')
  " augroup lsp
    " au!
    " au FileType java lua jdtls.start_or_attach({cmd={'launch_jdtls.sh'}})
  " augroup end
" endif

""""""python2 and python3 configuration"""""
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
"""""""Nerdtree""""""
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

