highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="jony"

" Values of the system colors already configured in the terimnal emulator's
" settings. Colors [0,15] are preconfigured. These values must be in sync with
" the terminal emulator's config.
let s:term_colors  = [
            \ '#000000',
            \ '#705050',
            \ '#60B48A',
            \ '#DFAF8F',
            \ '#506070',
            \ '#DC8CC3',
            \ '#8CD0D3',
            \ '#DCDCCC',
            \ '#709080',
            \ '#DCA3A3',
            \ '#C3BF9F',
            \ '#F0DFAF',
            \ '#94BFF3',
            \ '#EC93D3',
            \ '#93E0E3',
            \ '#FFFFFF',
            \]

"""""""""""""""""" COMMENT THE HELL OUT OF THE FUNCTIONS

" Flag to the 'hl' functions that instruct them to deduce the value of the
" parameter. At the moment, only deducing the value of 'guifg' and 'guibg'
" from the 's:term_colors' array is supported. However, if it's possible to
" deduce the value but you want to overwrite it, then simply pass in the new
" value.
let s:DEDUCE = 'DEDUCE'

" Checks to see if the attributes passed in aren't empty.
" Used for the 'cterm' and 'gui' parameters for 'highlight'.
"
" Returns a string suitable for use in formatting a 'hi' command.
function s:format_attr(attr, attr_param, keep_prev_hls)
    if a:attr->empty()
        return a:keep_prev_hls ? "" : printf("%s=none", a:attr_param)
    else
        return printf("%s=%s", a:attr_param, a:attr)
endfunction

" Checks to see if the colors passed in to 'ctermfg' and 'ctermbg' aren't
" empty.
"
" Returns a string suitable for use in formatting a 'hi' command.
function s:format_cterm_color(color, cterm_param, keep_prev_hls)
    if a:color->empty()
        return a:keep_prev_hls ? "" : printf("%s=none", a:cterm_param)
    else
        return printf("%s=%d", a:cterm_param, a:color)
endfunction

" Checks to see if the colors passed in to 'guifg' and 'guibg' aren't
" empty and deduces the value of the 'gui' colors if instructed to.
"
" Returns a string suitable for use in formatting a 'hi' command.
function s:format_gui_color(color, deduced_index, gui_param, keep_prev_hls)
    if a:color->empty()
        return a:keep_prev_hls ? "" : printf("%s=none", a:gui_param)
    elseif a:color == s:DEDUCE
        return printf("%s=%s", a:gui_param, s:term_colors[a:deduced_index])
    else
        return printf("%s=%s", a:gui_param, a:color)
endfunction

" Returns a formatted string that can be used as arguments to the 'hl'
" command. This functino defaults to removing the previous highlights of the
" commands, if you wish to keep them, then set 'keep_prev_hls' to '1'.
function s:format_hl_args(ctermfg, ctermbg, cterm, guifg, guibg, gui, keep_prev_hls = 0)
    " Bail if they're all empty.
    if a:ctermfg->empty() && a:ctermbg->empty() && a:cterm->empty()
                \&& a:guifg->empty() && a:guibg->empty() && a:gui->empty()
        return ""
    endif

    let l:ctermfg = s:format_cterm_color(a:ctermfg, "ctermfg", a:keep_prev_hls)
    let l:ctermbg = s:format_cterm_color(a:ctermbg, "ctermbg", a:keep_prev_hls)
    let l:cterm = s:format_attr(a:cterm, "cterm", a:keep_prev_hls)

    let l:guifg = s:format_gui_color(a:guifg, a:ctermfg, "guifg", a:keep_prev_hls)
    let l:guibg = s:format_gui_color(a:guibg, a:ctermbg, "guibg", a:keep_prev_hls)
    let l:gui = s:format_attr(a:gui, "gui", a:keep_prev_hls)

    return printf("%s %s %s %s %s %s", l:ctermfg, l:ctermbg, l:cterm, l:guifg, l:guibg, l:gui)
endfunction

" Defines a highlight group. If they are all empty, then clear the group.
"
" All arguments, aside from 'ctermfg' and 'ctermbg', expect strings.
" 'ctermfg' and 'ctermbg' must be integers.
function s:hl(group, ctermfg, ctermbg, cterm, guifg, guibg, gui)
    let l:formatted_args = s:format_hl_args(a:ctermfg, a:ctermbg, a:cterm, a:guifg, a:guibg, a:gui)

    if l:formatted_args->empty()
        let l:hl_call = printf("hi clear %s", a:group)
    else
        let l:hl_call = printf("hi %s %s", a:group, l:formatted_args)
    endif

    execute l:hl_call
endfunction

"-------------------------------------------------------------------------------------------
"         Syntax group      | ctermfg | ctermbg | cterm |  guifg  |   guibg |     gui      |
"-------------------------------------------------------------------------------------------

" --------------------------------
" Editor settings
" --------------------------------
call s:hl("Normal"            , 188,   0,            "", "#D7D7D7",  s:DEDUCE,            "")
call s:hl("Cursor"            , 233, 153,            "", "#121212", "#AFD7FF",            "")
call s:hl("CursorLine"        ,  "", 234,            "",        "", "#1C1C1C",            "")
call s:hl("LineNr"            , 244,  "",      "italic", "#808080",        "",      "italic")
call s:hl("CursorLineNR"      , 255,  "",      "italic", "#EEEEEE",        "",      "italic")

" -----------------
" - Number column -
" -----------------
call s:hl("CursorColumn"      ,  "", 234,            "",        "", "#1C1C1C",            "")
call s:hl("FoldColumn"        ,  59,  "",            "", "#5F5F5F",        "",            "")
call s:hl("SignColumn"        , 243, 236,            "", "#767676", "#303030",            "")
call s:hl("Folded"            ,  "", 234,            "",        "", "#1C1C1C",            "")

" -------------------------
" - Window/Tab delimiters -
" -------------------------
call s:hl("VertSplit"         , 243,  16,            "", "#767676", "#000000",            "")
call s:hl("ColorColumn"       ,  "",  16,            "",        "", "#000000",            "")
call s:hl("TabLine"           ,  16, 145,            "", "#000000", "#AFAFAF",            "")
call s:hl("TabLineFill"       , 103,  "",            "", "#8787AF",        "",            "")
call s:hl("TabLineSel"        ,  16, 255,            "", "#000000", "#EEEEEE",            "")

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call s:hl("Directory"         , 186,  "",            "", "#D7D787",        "",            "")
call s:hl("Search"            , 180,  90,            "", "#D7AF87", "#870087",            "")
call s:hl("IncSearch"         , 180,  90,            "", "#D7AF87", "#870087",            "")

" -----------------
" - Prompt/Status -
" -----------------
call s:hl("StatusLine"        ,  16, 253,            "", "#000000", "#DADADA",            "")
call s:hl("StatusLineNC"      , 231,  16,            "", "#FFFFFF", "#000000",            "")
call s:hl("WildMenu"          , 217,  16,            "", "#FFAFAF", "#000000",            "")
call s:hl("Question"          ,  71,  "",            "", "#5FAF5F",        "",            "")
call s:hl("Title"             ,  71,  "",            "", "#5FAF5F",        "",            "")
call s:hl("ModeMsg"           ,  "",  "",            "",        "",        "",            "")
call s:hl("MoreMsg"           ,  "",  "",            "",        "",        "",            "")

" --------------
" - Visual aid -
" --------------
call s:hl("MatchParen"        , 231,  60,            "", "#FFFFFF", "#5F5F87",            "")
call s:hl("Visual"            ,  "", 237,            "",        "", "#3A3A3A",            "")
call s:hl("VisualNOS"         ,  "", 235,            "",        "", "#262626",            "")
call s:hl("NonText"           , 240,   0,            "", "#585858",  s:DEDUCE,            "")
call s:hl("Todo"              ,   0,  11,            "",  s:DEDUCE,  s:DEDUCE,            "")
call s:hl("Underlined"        ,  "",  "",            "",        "",        "",            "")
call s:hl("Error"             ,  "",  "",            "",        "",        "",            "")
call s:hl("ErrorMsg"          ,  "",  88,            "",        "", "#870000",            "")
call s:hl("WarningMsg"        ,  "",  "",            "",        "",        "",            "")
call s:hl("Ignore"            ,  "",  "",            "",        "",        "",            "")
call s:hl("SpecialKey"        , 238, 234,            "", "#444444", "#1C1C1C",            "")

" --------------------------------
" Diff
" --------------------------------
call s:hl("DiffAdd"           , 193,  22,            "", "#D7FFAF", "#005F00",            "")
call s:hl("DiffChange"        ,  "",  24,            "",        "", "#005F87",            "")
call s:hl("DiffDelete"        ,  16,  52,            "", "#000000", "#5F0000",            "")
call s:hl("DiffText"          , 110,  16,            "", "#87AFD7", "#000000",            "")

" --------------------------------
" Completion menu
" --------------------------------
call s:hl("Pmenu"             , 231, 235,            "", "#FFFFFF", "#262626",            "")
call s:hl("PmenuSel"          , 232, 255,            "", "#080808", "#EEEEEE",            "")
call s:hl("PmenuSbar"         ,  "",  "",            "",        "",        "",            "")
call s:hl("PmenuThumb"        ,  "",  "",            "",        "",        "",            "")

" --------------------------------
" Spelling
" --------------------------------
call s:hl("SpellBad"          ,  "",  88,            "",        "", "#870000",            "")
call s:hl("SpellCap"          ,  "",  20,            "",        "", "#0000D7",            "")
call s:hl("SpellLocal"        ,  "",  23,            "",        "", "#005F5F",            "")
call s:hl("SpellRare"         ,  "",  53,            "",        "", "#5F005F",            "")

" --------------------------------
" Variable types
" --------------------------------
call s:hl("Variable"          , 248,  "",            "", "#A8A8A8",        "",            "")
call s:hl("StringDelimiter"   ,  58,  "",            "", "#5F5F00",        "",            "")
call s:hl("Identifier"        , 183,  "",            "", "#D7AFFF",        "",            "")

" --------------------------------
" Language constructs
" --------------------------------

"  These should be linked to each other
call s:hl("Statement"         ,  14,  "",            "",  s:DEDUCE,        "",            "")
call s:hl("Conditional"       ,  14,  "",            "",  s:DEDUCE,        "",            "")
call s:hl("Repeat"            ,  14,  "",            "",  s:DEDUCE,        "",            "")
call s:hl("Label"             ,  14,  "",            "",  s:DEDUCE,        "",            "")
call s:hl("Operator"          ,  14,  "",            "",  s:DEDUCE,        "",            "")
call s:hl("Keyword"           ,  14,  "",            "",  s:DEDUCE,        "",            "")
call s:hl("Exception"         ,  14,  "",            "",  s:DEDUCE,        "",            "")
"
call s:hl("Special"           , 128,  "",            "", "#AF00D7",        "",            "")
call s:hl("SpecialChar"       ,  96,  "",            "", "#875F87",        "",            "")
call s:hl("Tag"               ,  "",  "",            "",        "",        "",            "")
call s:hl("Delimiter"         ,  66,  "",            "", "#5F8787",        "",            "")
call s:hl("SpecialComment"    ,  "",  "",            "",        "",        "",            "")
call s:hl("Debug"             ,  "",  "",            "",        "",        "",            "")

" ----------
" - C like -
" ----------
call s:hl("PreProc"           ,  97,  "",            "", "#875FAF",        "",            "")
call s:hl("Include"           ,  97,  "",            "", "#875FAF",        "",            "")
call s:hl("Define"            ,  97,  "",            "", "#875FAF",        "",            "")
call s:hl("Macro"             ,  97,  "",            "", "#875FAF",        "",            "")
call s:hl("PreCondit"         ,  97,  "",            "", "#875FAF",        "",            "")
call s:hl("Type"              , 173,  "",            "", "#D7875F",        "",            "")
call s:hl("StorageClass"      , 173,  "",            "", "#D7875F",        "",            "")
call s:hl("Structure"         , 173,  "",            "", "#D7875F",        "",            "")
call s:hl("Typedef"           ,  "",  "",            "",        "",        "",            "")

hi def link Structure Typedef

"--------------------------------------------------------------------
" Specific settings                                                 |
"--------------------------------------------------------------------
call s:hl("String"            , 107,  "",      "italic", "#87AF5F",        "",      "italic")
call s:hl("Character"         , 107,  "",      "italic", "#87AF5F",        "",      "italic")
call s:hl("Constant"          , 141,  "", "bold,italic", "#AF87FF",        "", "bold,italic")
call s:hl("Number"            , 141,  "",            "", "#AF87FF",        "",            "")
call s:hl("Boolean"           , 141,  "",            "", "#AF87FF",        "",            "")
call s:hl("Float"             , 141,  "",            "", "#AF87FF",        "",            "")
call s:hl("Function"          , 221,  "",            "", "#FFD75F",        "",            "")
call s:hl("Member"            ,  81,  "",            "", "#5FD7FF",        "",            "")
call s:hl("Comment"           , 167,  "",      "italic", "#D75F5F",        "",      "italic")

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
