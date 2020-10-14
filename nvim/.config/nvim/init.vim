set nocompatible

call plug#begin(stdpath('data') . '/plugged')
    Plug 'airblade/vim-gitgutter'
call plug#end()

set number
set relativenumber
set title
set lazyredraw
set ruler

set showmatch
set laststatus=2

" tab settings
set tabstop=4     " a tab is the equivalent of 4 spaces
set shiftwidth=4  " an indentation is 4 spaces wide
set expandtab     " tabs converted to spaces

syntax on
set autoindent
set showcmd
set hlsearch incsearch

set clipboard=unnamedplus

set splitright " when splitting vertically, split right
set splitbelow " when splitting horizontally, split below

" needed to make the c & cpp 'clang-format on save work'
" neovim sets it by default, vim doesn't
filetype plugin on

" move around splits
nnoremap <Space>h <C-W>h
nnoremap <Space>l <C-W>l
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k

" have functionality match that of C and D
nnoremap Y y$

" mimic common indenting mappings from IDEs
vnoremap <silent> <Tab>   >gv
vnoremap <silent> <S-Tab> <gv
nnoremap <Tab>   >>
nnoremap <S-Tab> <<

" disable Ex mode
noremap Q <Nop>

" https://vim.fandom.com/wiki/Highlight_unwanted_spaces
" This line is needed to make sure colorschemes don't clear all
" user-defined highlight groups
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=109 guibg=red

" Choose one of two options for choosing if the line I'm on should be
" highlighted for TrailingWhitespace.

" 1.)
" Will match trailing whitespace except for the line I'm on
"autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match TrailingWhitespace /\s\+$/

" 2.)
" Will match trailing whitespace, even the line I'm on
autocmd InsertEnter,InsertLeave * match TrailingWhitespace /\s\+$/

" TrailingWhitespace is matched whenever we're in splits or tabs or
" recently open a file.
autocmd VimEnter,WinEnter * match TrailingWhitespace /\s\+$/

colo jony
" For git-gutter
set updatetime=100
