set nocompatible

let mapleader = " " " Giving this a whirl

call plug#begin(stdpath('data') . '/plugged')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'ray-x/lsp_signature.nvim'

    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
    Plug 'nvim-treesitter/playground'

    "Plug 'jackguo380/vim-lsp-cxx-highlight'

    Plug 'SirVer/ultisnips'

    Plug 'airblade/vim-gitgutter'
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

syntax on
set autoindent
set showcmd
set hlsearch incsearch

set clipboard=unnamedplus

set splitright " when splitting vertically, split right
set splitbelow " when splitting horizontally, split below

set hidden " easier navigation between files without saving the one I'm on

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

" 2.)
" Will match trailing whitespace, even the line I'm on
autocmd InsertEnter,InsertLeave * match TrailingWhitespace /\s\+$/

" TrailingWhitespace is matched whenever we're in splits or tabs or
" recently open a file.
autocmd VimEnter,WinEnter * match TrailingWhitespace /\s\+$/

colo jony

lua <<END
    require'config/lsp'
    require'config/treesitter'
END


" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_matching_strategy_list = ['exact', 'fuzzy', 'substring', 'all']
let g:completion_enable_snippet = 'UltiSnips'

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

" Setup the syntax highlighting how I want.
" I will eventually change to tree sitter once Neovim_v5.0 is released.
hi! link LspCxxHlGroupMemberVariable Member
hi! link LspCxxHlSymVariable Variable
hi! link LspCxxHlSymParameter Variable

" For git-gutter
set updatetime=100

nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hN <Plug>(GitGutterPrevHunk)

augroup FixCHeaderFiles
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END
