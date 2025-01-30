local lush = require("lush")

-- luacheck: no global
vim.g.colors_name = "excolo"

-- luacheck: no global
vim.opt.background = "dark"

local theme = lush(function()
    return {
        SpecialKey                             { bg="#1c1c1c", fg="#444444", },
        NonText                                { bg="#000000", fg="#585858", },
        Directory                              { fg="#d7d787", },
        Underlined                             { },
        Error                                  { },
        ErrorMsg                               { bg="#870000", },
        WarningMsg                             { },
        Ignore                                 { },
        IncSearch                              { bg="#870087", fg="#d7af87", },
        Search                                 { bg="#870087", fg="#d7af87", },
        LineNr                                 { gui="italic", fg="#808080", },
        Question                               { fg="#5faf5f", },
        StatusLine                             { bg="#dadada", fg="#000000", },
        StatusLineNC                           { bg="#000000", fg="#ffffff", },
        VertSplit                              { bg="#000000", fg="#767676", },
        Title                                  { fg="#5faf5f", },
        ModeMsg                                { },
        MoreMsg                                { },
        Visual                                 { bg="#3a3a3a", },
        WildMenu                               { bg="#000000", fg="#ffafaf", },
        Folded                                 { bg="#1c1c1c", },
        FoldColumn                             { fg="#5f5f5f", },
        DiffAdd                                { bg="#005f00", fg="#d7ffaf", },
        DiffChange                             { bg="#005f87", },
        DiffDelete                             { bg="#5f0000", fg="#000000", },
        DiffText                               { bg="#000000", fg="#87afd7", },
        SignColumn                             { },
        SpellBad                               { bg="#870000", sp="red", },
        SpellCap                               { bg="#0000d7", sp="blue", },
        SpellRare                              { bg="#5f005f", sp="magenta", },
        SpellLocal                             { bg="#005f5f", sp="cyan", },
        Pmenu                                  { bg="#262626", fg="#ffffff", },
        PmenuSel                               { bg="#eeeeee", fg="#080808", },
        PmenuSbar                              { },
        PmenuThumb                             { },
        TabLine                                { bg="#afafaf", fg="#000000", },
        TabLineSel                             { bg="#eeeeee", fg="#000000", },
        TabLineFill                            { fg="#8787af", },
        CursorColumn                           { bg="#1c1c1c", },
        CursorLine                             { bg="#1c1c1c", },
        CursorLineNr                           { gui="italic", fg="#eeeeee", },
        ColorColumn                            { bg="#000000", },
        Cursor                                 { bg="#afd7ff", fg="#121212", },
        Normal                                 { bg="#000000", fg="#d7d7d7", },
        Todo                                   { bg="#f0dfaf", fg="#000000", },
        String                                 { gui="italic", fg="#87af5f", },
        Constant                               { gui="bold,italic", fg="#af87ff", },
        Character                              { gui="italic", fg="#87af5f", },
        Number                                 { fg="#af87ff", },
        Boolean                                { fg="#af87ff", },
        Float                                  { fg="#af87ff", },
        Function                               { fg="#ffd75f", },
        Identifier                             { fg="#d7afff", },
        Conditional                            { fg="#93e0e3", },
        Statement                              { fg="#93e0e3", },
        Repeat                                 { fg="#93e0e3", },
        Label                                  { fg="#93e0e3", },
        Operator                               { fg="#93e0e3", },
        Keyword                                { fg="#93e0e3", },
        Exception                              { fg="#93e0e3", },
        Include                                { fg="#875faf", },
        PreProc                                { fg="#875faf", },
        Define                                 { fg="#875faf", },
        Macro                                  { fg="#875faf", },
        PreCondit                              { fg="#875faf", },
        StorageClass                           { fg="#d7875f", },
        Type                                   { fg="#d7875f", },
        Typedef                                { Type, },
        Structure                              { fg="#d7875f", },
        Special                                { fg="#af00d7", },
        Tag                                    { Special, },
        SpecialComment                         { Special, },
        Debug                                  { Special, },
        SpecialChar                            { fg="#875f87", },
        Delimiter                              { fg="#5f8787", },
        Comment                                { gui="italic", fg="#d75f5f", },
        MatchParen                             { bg="#5f5f87", fg="#ffffff", },
        VisualNOS                              { bg="#262626", },
        Variable                               { fg="#a8a8a8", },
        StringDelimiter                        { fg="#5f5f00", },
        Member                                 { fg="#5fd7ff", },
        TrailingWhitespace                     { bg="red", },
    }
end)

local diagnostic_groups = lush(function()
    return {
        DiagnosticError                        { fg="red", },
        DiagnosticHint                         { fg="lightgrey", },
        DiagnosticInfo                         { fg="teal", },
        DiagnosticWarn                         { fg="orange", },

        DiagnosticFloatingError                { DiagnosticError, },
        DiagnosticFloatingHint                 { DiagnosticHint, },
        DiagnosticFloatingInfo                 { DiagnosticInfo, },
        DiagnosticFloatingWarn                 { DiagnosticWarn, },

        DiagnosticSignError                    { DiagnosticError, },
        DiagnosticSignHint                     { DiagnosticHint, },
        DiagnosticSignInfo                     { DiagnosticInfo, },
        DiagnosticSignWarn                     { DiagnosticWarn, },

        DiagnosticUnderlineError               { sp="red", gui="underline", },
        DiagnosticUnderlineHint                { sp="lightgrey", gui="underline", },
        DiagnosticUnderlineInfo                { sp="lightblue", gui="underline", },
        DiagnosticUnderlineWarn                { sp="orange", gui="underline", },

        DiagnosticVirtualTextError             { DiagnosticError, },
        DiagnosticVirtualTextHint              { DiagnosticHint, },
        DiagnosticVirtualTextInfo              { DiagnosticInfo, },
        DiagnosticVirtualTextWarn              { DiagnosticWarn, },
    }
end)

local gitsigns_groups = lush(function()
    return {
        GitSignsAdd                           { theme.DiffAdd, },
        GitSignsAddLine                       { GitSignsAdd, },
        GitSignsAddLineNr                     { GitSignsAdd, },

        GitSignsChange                        { theme.DiffChange, },
        GitSignsChangeLine                    { GitSignsChange, },
        GitSignsChangeLineNr                  { GitSignsChange, },

        GitSignsDelete                        { theme.DiffDelete, },
        GitSignsDeleteLine                    { GitSignsDelete, },
        GitSignsDeleteLineNr                  { GitSignsDelete, },
    }
end)

local treesitter_groups = lush(function(injected_functions)
    local sym = injected_functions.sym

    return {
        -- Misc
        -- sym("@comment") {}, -- line and block comments
        -- sym("@error") {}, -- syntax/parser errors
        -- sym("@none") {}, -- completely disable the highlight
        -- sym("@preproc") {}, -- various preprocessor directives & shebangs
        -- sym("@define") {}, -- preprocessor definition directives
        -- sym("@operator") {}, -- symbolic operators (e.g. `+` / `*`)

        -- Punctuation
        -- sym("@punctuation.delimiter") {}, -- delimiters (e.g. `;` / `.` / `,`)
        -- sym("@punctuation.bracket") {}, -- brackets (e.g. `()` / `{}` / `[]`)
        -- sym("@punctuation.special") {}, -- special symbols (e.g. `{}` in string interpolation)

        -- Literals
        -- sym("@string") {}, -- string literals
        -- sym("@string.regex") {}, -- regular expressions
        -- sym("@string.escape") {}, -- escape sequences
        -- sym("@string.special") {}, -- other special strings (e.g. dates)

        -- sym("@character") {}, -- character literals
        -- sym("@character.special") {}, -- special characters (e.g. wildcards)

        -- sym("@boolean") {}, -- boolean literals
        -- sym("@number") {}, -- numeric literals
        -- sym("@float") {}, -- floating-point number literals

        -- Functions
        -- sym("@function") {}, -- function definitions
        sym("@function.builtin") { theme.Function }, -- built-in functions
        -- sym("@function.call") {}, -- function calls
        -- sym("@function.macro") {}, -- preprocessor macros

        -- sym("@method") {}, -- method definitions
        -- sym("@method.call") {}, -- method calls

        sym("@constructor") { theme.Function }, -- constructor calls and definitions
        sym("@parameter") { theme.Variable }, -- parameters of a function

        -- Keywords
        -- sym("@keyword") {}, -- various keywords
        -- sym("@keyword.function") {}, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
        -- sym("@keyword.operator") {}, -- operators that are English words (e.g. `and` / `or`)
        -- sym("@keyword.return") {}, -- keywords like `return` and `yield`

        -- sym("@conditional") {}, -- keywords related to conditionals (e.g. `if` / `else`)
        -- sym("@repeat") {}, -- keywords related to loops (e.g. `for` / `while`)
        -- sym("@debug") {}, -- keywords related to debugging
        -- sym("@label") {}, -- GOTO and other labels (e.g. `label:` in C)
        -- sym("@include") {}, -- keywords for including modules (e.g. `import` / `from` in Python)
        -- sym("@exception") {}, -- keywords related to exceptions (e.g. `throw` / `catch`)

        -- Types
        --sym("@type") {}, -- type or class definitions and annotations
        --sym("@type.builtin") {}, -- built-in types
        --sym("@type.definition") {}, -- type definitions (e.g. `typedef` in C)
        --sym("@type.qualifier") {}, -- type qualifiers (e.g. `const`)

        --sym("@storageclass") {}, -- visibility/life-time modifiers
        --sym("@storageclass.lifetime") {}, -- life-time modifiers (e.g. `static`)
        --sym("@attribute") {}, -- attribute annotations (e.g. Python decorators)
        sym("@field") { theme.Member }, -- object and struct fields
        sym("@property") { theme.Member }, -- similar to `@field`

        -- Identifiers
        sym("@variable") { theme.Variable }, -- various variable names
       -- sym("@variable.builtin") {}, -- built-in variable names (e.g. `this`)

       -- sym("@constant") {}, -- constant identifiers
       -- sym("@constant.builtin") {}, -- built-in constant values
       -- sym("@constant.macro") {}, -- constants defined by the preprocessor

       -- sym("@namespace") {}, -- modules or namespaces
       -- sym("@symbol") {}, -- symbols or atoms

        -- Text

        -- Mainly for markup languages.
        -- sym("@text") {}, -- non-structured text
        -- sym("@text.strong") {}, -- bold text
        -- sym("@text.emphasis") {}, -- text with emphasis
        -- sym("@text.underline") {}, -- underlined text
        -- sym("@text.strike") {}, -- strikethrough text
        -- sym("@text.title") {}, -- text that is part of a title
        -- sym("@text.literal") {}, -- literal or verbatim text
        -- sym("@text.uri") {}, -- URIs (e.g. hyperlinks)
        -- sym("@text.math") {}, -- math environments (e.g. `$ ... $` in LaTeX)
        -- sym("@text.environment") {}, -- text environments of markup languages
        -- sym("@text.environment.name") {}, -- text indicating the type of an environment
        -- sym("@text.reference") {}, -- text references, footnotes, citations, etc.

        -- sym("@text.todo") {}, -- todo notes
        -- sym("@text.note") {}, -- info notes
        -- sym("@text.warning") {}, -- warning notes
        -- sym("@text.danger") {}, -- danger/error notes

        -- sym("@text.diff.add") {}, -- added text (for diff files)
        -- sym("@text.diff.delete") {}, -- deleted text (for diff files)

        -- Tags
        -- Used for XML-like tags.
        -- sym("@tag") {}, -- XML tag names
        -- sym("@tag.attribute") {}, -- XML tag attributes
        -- sym("@tag.delimiter") {}, -- XML tag delimiters

        -- Conceal
        -- sym("@conceal") {}, -- for captures that are only used for concealing
                            -- @conceal must be followed by (#set! conceal "").

        -- Spell
        -- sym("@spell") {}, -- for defining regions to be spellchecked
    }
end)

local final_spec = lush.merge({theme, diagnostic_groups, gitsigns_groups, treesitter_groups})

lush(final_spec)
