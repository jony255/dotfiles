set nocompatible

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

colo jony
