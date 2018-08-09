#! /bin/zsh
setopt EXTENDED_GLOB
for filepath in $HOME/.dotFiles/files/*; do
	local filename=${filepath:t}
    if [ -e $HOME/.$filename ]; then
        mv $HOME/.$filename $HOME/.$filename.bak
    fi
	ln -snfv $filepath $HOME/.$filename
done

if [ ! -e $HOME/.vim/bundle ]; then
	mkdir ~/.vim/bundle
else
	echo 'already make bundle'
fi
if [ ! -e $HOME/.vim/dein/repos/github.com/Shougo/dein.vim ]; then
	git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
else
	echo 'already git clone Shougo/dein.vim'
fi
