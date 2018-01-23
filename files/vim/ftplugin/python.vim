setlocal tabstop=4
setlocal noexpandtab

if matchstr(expand("%:p:h"), "timestamp") == "timestamp"
    setlocal expandtab
    let g:syntastic_python_pylint_exec = "pylint"
    let g:syntastic_python_pycodestyle_exec = "pycodestyle"
    let g:syntastic_python_pycodestyle_args = "--config=.pycodestyle"
endif
