set nocompatible

let mapleader = " " " Giving this a whirl

call plug#begin()
    Plug 'neovim/nvim-lspconfig'
    Plug 'ray-x/lsp_signature.nvim'

    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'uga-rosa/cmp-dictionary'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'nvim-lua/plenary.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    Plug 'SirVer/ultisnips'

    Plug 'lewis6991/gitsigns.nvim'

    Plug 'pest-parser/pest.vim'
call plug#end()

set number
set relativenumber
set title
set lazyredraw
set ruler

set nowrap

set showmatch
set laststatus=2

" tab settings
set tabstop=4     " a tab is the equivalent of 4 spaces
set shiftwidth=4  " an indentation is 4 spaces wide
set expandtab     " tabs converted to spaces

" Treesitter disables this by default since it might clash with the
" highlighting provided by treesitter; however, this behavior can be modified.
" I'm keeping it on regardless though to make moving from neovim to vim more
" easy should I ever need to in the future.
syntax on

set spelloptions=noplainbuffer

set autoindent
set showcmd
set hlsearch incsearch

set clipboard=unnamedplus

set splitright " when splitting vertically, split right
set splitbelow " when splitting horizontally, split below

set hidden " easier navigation between files without saving the one I'm on

set cursorline

set shortmess+=I

" needed to make the c & cpp 'clang-format on save work'
" neovim sets it by default, vim doesn't
filetype plugin on

" move around splits
"nnoremap <Space>h <C-W>h
"nnoremap <Space>l <C-W>l
"nnoremap <Space>j <C-W>j
"nnoremap <Space>k <C-W>k

" have functionality match that of C and D
nnoremap Y y$

" mimic common indenting mappings from IDEs
vnoremap <silent> <Tab>   >gv
vnoremap <silent> <S-Tab> <gv
nnoremap <Tab>   >>
nnoremap <S-Tab> <<

" disable Ex mode
noremap Q <Nop>

" use ESC to turn off highlights
nmap <silent> <Esc> <cmd>noh<CR>

" From https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
" center screen after scrolling to the next search term
nnoremap n nzz
nnoremap N Nzz

nnoremap <leader>p <cmd>FZF<CR>

" https://vim.fandom.com/wiki/Highlight_unwanted_spaces
" This line is needed to make sure colorschemes don't clear all
" user-defined highlight groups
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=109 guibg=#87afaf

" Choose one of two options for choosing if the line I'm on should be
" highlighted for TrailingWhitespace.

" 1.)
" Will match trailing whitespace except for the line I'm on
"autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/

" 2.)
" Will match trailing whitespace, even the line I'm on
autocmd InsertEnter,InsertLeave * match TrailingWhitespace /\s\+$/

" TrailingWhitespace is matched whenever we're in splits or tabs or
" recently open a file.
autocmd VimEnter,WinEnter * match TrailingWhitespace /\s\+$/

colo jony_ng

lua <<END
    require('config').setup()
END

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:UltiSnipsSnippetDirectories = [stdpath('config').'/ulti_snips']
let g:UltiSnipsExpandTrigger = '<NOP>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

hi DiagnosticVirtualTextError ctermbg=160
hi DiagnosticSignError ctermbg=160

hi DiagnosticVirtualTextWarning ctermbg=160
hi DiagnosticSignWarning ctermbg=160

hi DiagnosticVirtualTextInformation ctermbg=160
hi DiagnosticSignInformation ctermbg=160

call sign_define("DiagnosticErrorSign", {"text" : "E", "texthl" : "DiagnosticError"})
call sign_define("DiagnosticWarningSign", {"text" : "W", "texthl" : "DiagnosticWarning"})
call sign_define("DiagnosticInformationSign", {"text" : "I", "texthl" : "DiagnosticInformation"})
call sign_define("DiagnosticHintSign", {"text" : "H", "texthl" : "DiagnosticHint"})

augroup FixCHeaderFiles
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END
