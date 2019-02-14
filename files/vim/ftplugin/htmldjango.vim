" in workspace
if matchstr(expand("%:p:h"), "/workspace") == "/workspace"
    setlocal tabstop=4
    setlocal noexpandtab
endif
