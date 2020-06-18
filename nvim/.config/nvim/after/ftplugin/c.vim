function! Formatonsave()
    let l:lines = "all"
    py3f /usr/share/clang/clang-format.py
endfunction

autocmd BufWritePre * call Formatonsave()
