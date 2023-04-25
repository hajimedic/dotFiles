setlocal tabstop=4
setlocal noexpandtab

" in workspace
if matchstr(expand("%:p:h"), "/workspace") == "/workspace"
    let _path = substitute(expand('%:p:h'),  '\(.*/workspace/[a-z-]\+\).*', '\1',  'g')
    let g:syntastic_python_pylint_exec = _path."/bin/pylint"
    let g:syntastic_python_pycodestyle_exec = _path."/bin/pycodestyle"
endif

" in timestamp
if matchstr(expand("%:p:h"), "timestamp") == "timestamp"
    setlocal expandtab
    let g:syntastic_python_pylint_exec = $HOME."/.pyenv/shims/pylint"
    let g:syntastic_python_pycodestyle_exec = $HOME."/.pyenv/shims/pycodestyle"
    let g:syntastic_python_pycodestyle_args = "--config=.pycodestyle"
endif

