set nocompatible

let mapleader = " " " Giving this a whirl

call plug#begin(stdpath('data') . '/plugged')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

    Plug 'nvim-treesitter/nvim-treesitter'
"    Plug 'nvim-treesitter/playground'

    Plug 'jackguo380/vim-lsp-cxx-highlight'

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
    local on_attach_vim = function(client)
        require'completion'.on_attach(client)
    end

    lsp_config = require'lspconfig'

    lsp_config.ccls.setup{
        on_attach=on_attach_vim,
        init_options = {
            highlight = {
                lsRanges = true;
            },
        }
    }

    lsp_config.rust_analyzer.setup({
        on_attach=on_attach_vim,
    })

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- This will disable virtual text, like doing:
        -- let g:diagnostic_enable_virtual_text = 0
        virtual_text = true,

        -- This is similar to:
        -- let g:diagnostic_show_sign = 1
        -- To configure sign display,
        --  see: ":help vim.lsp.diagnostic.set_signs()"
        signs = true,

        -- This is similar to:
        -- "let g:diagnostic_insert_delay = 1"
        update_in_insert = true,
      }
    )

    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = false,    -- false will disable the whole extension
        },
        indent = {
            enable = true,
        },
--        playground = {
--            enable = true,
--            disable = {},
--            updatetime = 1, -- Debounced time for highlighting nodes in the playground from source code
--            persist_queries = false -- Whether the query persists across vim sessions
--        }
    }

    -- https://github.com/nvim-treesitter/nvim-treesitter#folding
    -- The nvim documentation (h: vim.o) says to use vim.o when you want to
    -- 'Get or set editor options, like :set' Which is what the link above
    -- does.
    --     set foldmethod=expr
    --     set foldexpr=nvim_treesitter#foldexpr()
    -- However the link does say that:
    --     Tree-sitter based folding.
    --         (Technically not a module because it's per windows and not per buffer.)
	-- Another thing to note is that (h: foldnestmax) says that its local to the window
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldnestmax = 2
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

hi LspDiagnosticsVirtualTextError ctermbg=160
hi LspDiagnosticsSignError ctermbg=160

hi LspDiagnosticsVirtualTextWarning ctermbg=160
hi LspDiagnosticsSignWarning ctermbg=160

hi LspDiagnosticsVirtualTextInformation ctermbg=160
hi LspDiagnosticsSignInformation ctermbg=160

call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

" Setup the syntax highlighting how I want.
" I will eventually change to tree sitter once Neovim_v5.0 is released.
hi! link LspCxxHlGroupMemberVariable Member
hi! link LspCxxHlSymVariable Variable
hi! link LspCxxHlSymParameter Variable

" For git-gutter
set updatetime=100

nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hN <Plug>(GitGutterPrevHunk)
