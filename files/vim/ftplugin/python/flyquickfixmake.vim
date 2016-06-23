" """ $HOME/.vim/ftplugin/python/flyquickfixmake.vim
" """ setting for pylint
" setlocal makeprg=$HOME/workspace/bin/pylint\ %
" " setlocal makeprg=$HOME/.pyenv/shims/pylint\ %
" setlocal errorformat=%t:%l:%m
"
" if !exists("g:python_flyquickfixmake")
"     let g:python_flyquickfixmake = 1
"     au BufWritePost *.py make
" endif
