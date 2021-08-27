highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="jony"

"----------------------------------------------------------------
" General settings                                              |
" Syntax group   | Foreground    | Background    | Style        |
"----------------------------------------------------------------

" --------------------------------
" Editor settings
" --------------------------------
hi Normal          ctermfg=188     ctermbg=0       cterm=none

hi Cursor          ctermfg=233     ctermbg=153     cterm=none
hi CursorLine      ctermfg=none    ctermbg=234     cterm=none
hi LineNr          ctermfg=244     ctermbg=none    cterm=italic
hi CursorLineNR    ctermfg=255     ctermbg=none    cterm=italic

" -----------------
" - Number column -
" -----------------
hi CursorColumn    ctermfg=none    ctermbg=234     cterm=none
hi FoldColumn      ctermfg=59      ctermbg=none     cterm=none
hi SignColumn      ctermfg=243     ctermbg=236     cterm=none
hi Folded          ctermfg=none    ctermbg=234     cterm=none

" -------------------------
" - Window/Tab delimiters -
" -------------------------
hi VertSplit       ctermfg=243     ctermbg=16      cterm=none
hi ColorColumn     ctermfg=none    ctermbg=16      cterm=none
hi TabLine         ctermfg=16      ctermbg=145     cterm=none
hi TabLineFill     ctermfg=103     ctermbg=none    cterm=none
hi TabLineSel      ctermfg=16      ctermbg=255     cterm=none

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
hi Directory       ctermfg=186     ctermbg=none   cterm=none
hi Search          ctermfg=180     ctermbg=90     cterm=none
hi IncSearch       ctermfg=180     ctermbg=90     cterm=none

" -----------------
" - Prompt/Status -
" -----------------
hi StatusLine      ctermfg=16      ctermbg=253     cterm=none
hi StatusLineNC    ctermfg=231     ctermbg=16      cterm=none
hi WildMenu        ctermfg=217     ctermbg=16      cterm=none
hi Question        ctermfg=71      ctermbg=none    cterm=none
hi Title           ctermfg=71      ctermbg=none    cterm=none
hi ModeMsg         ctermfg=none    ctermbg=none    cterm=none
hi MoreMsg         ctermfg=none    ctermbg=none    cterm=none

" --------------
" - Visual aid -
" --------------
hi MatchParen      ctermfg=231     ctermbg=60      cterm=none
hi Visual          ctermfg=none    ctermbg=237     cterm=none
hi VisualNOS       ctermfg=none    ctermbg=235     cterm=none
hi NonText         ctermfg=240     ctermbg=0       cterm=none
hi Todo            ctermfg=0       ctermbg=11      cterm=none
hi Underlined      ctermfg=none    ctermbg=none    cterm=none
hi Error           ctermfg=none    ctermbg=none    cterm=none
hi ErrorMsg        ctermfg=none    ctermbg=88      cterm=none
hi WarningMsg      ctermfg=none    ctermbg=none    cterm=none
hi Ignore          ctermfg=none    ctermbg=none    cterm=none
hi SpecialKey      ctermfg=238     ctermbg=234     cterm=none

" --------------------------------
" Diff
" --------------------------------
hi DiffAdd         ctermfg=193     ctermbg=22      cterm=none
hi DiffChange      ctermfg=none    ctermbg=24      cterm=none
hi DiffDelete      ctermfg=16      ctermbg=52      cterm=none
hi DiffText        ctermfg=110     ctermbg=16      cterm=none

" --------------------------------
" Completion menu
" --------------------------------
hi Pmenu           ctermfg=231     ctermbg=240     cterm=none
hi PmenuSel        ctermfg=232     ctermbg=255     cterm=none
hi PmenuSbar       ctermfg=none    ctermbg=none    cterm=none
hi PmenuThumb      ctermfg=none    ctermbg=none    cterm=none

" --------------------------------
" Spelling
" --------------------------------
hi SpellBad        ctermfg=none    ctermbg=88      cterm=none
hi SpellCap        ctermfg=none    ctermbg=20      cterm=none
hi SpellLocal      ctermfg=none    ctermbg=23      cterm=none
hi SpellRare       ctermfg=none    ctermbg=53      cterm=none

" --------------------------------
" Variable types
" --------------------------------
hi Variable        ctermfg=248     ctermbg=none    cterm=none
hi StringDelimiter ctermfg=58      ctermbg=none    cterm=none
hi Identifier      ctermfg=183     ctermbg=none    cterm=none

" --------------------------------
" Language constructs
" --------------------------------
hi Statement       ctermfg=14      ctermbg=none    cterm=none
hi Conditional     ctermfg=14      ctermbg=none    cterm=none
hi Repeat          ctermfg=14      ctermbg=none    cterm=none
hi Label           ctermfg=14      ctermbg=none    cterm=none
hi Operator        ctermfg=14      ctermbg=none    cterm=none
hi Keyword         ctermfg=14      ctermbg=none    cterm=none
hi Exception       ctermfg=14      ctermbg=none    cterm=none

hi Special         ctermfg=107     ctermbg=none    cterm=none
hi SpecialChar     ctermfg=96      ctermbg=none    cterm=none
hi Tag             ctermfg=none    ctermbg=none    cterm=none
hi Delimiter       ctermfg=66      ctermbg=none    cterm=none
hi SpecialComment  ctermfg=none    ctermbg=none    cterm=none
hi Debug           ctermfg=none    ctermbg=none    cterm=none

" ----------
" - C like -
" ----------
hi PreProc         ctermfg=97      ctermbg=none    cterm=none
hi Include         ctermfg=97      ctermbg=none    cterm=none
hi Define          ctermfg=97      ctermbg=none    cterm=none
hi Macro           ctermfg=97      ctermbg=none    cterm=none
hi PreCondit       ctermfg=97      ctermbg=none    cterm=none

hi Type            ctermfg=173     ctermbg=none    cterm=none
hi StorageClass    ctermfg=173     ctermbg=none    cterm=none
hi Structure       ctermfg=173     ctermbg=none    cterm=none
hi Typedef         ctermfg=none    ctermbg=none    cterm=none

hi def link Structure Typedef

"--------------------------------------------------------------------
" Specific settings                                                 |
"--------------------------------------------------------------------
hi String          ctermfg=107     ctermbg=none    cterm=italic
hi Character       ctermfg=107     ctermbg=none    cterm=italic
hi Constant        ctermfg=141     ctermbg=none    cterm=bold,italic
hi Number          ctermfg=141     ctermbg=none    cterm=none
hi Boolean         ctermfg=141     ctermbg=none    cterm=none
hi Float           ctermfg=141     ctermbg=none    cterm=none
hi Function        ctermfg=221     ctermbg=none    cterm=none
hi Member          ctermfg=81      ctermbg=none    cterm=none

hi Comment         ctermfg=167     ctermbg=none    cterm=italic
" cool yellowy color 221

"--------------------------------------------------------------------
" Tree Sitter links
"--------------------------------------------------------------------
hi link TSField    Member
hi link TSProperty Member
hi link TSConstructor Function
hi link TSFuncBuiltin Function

hi link TSParameter          Variable
hi link TSParameterReference Variable
hi link TSVariable           Variable
