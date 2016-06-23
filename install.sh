#! /bin/zsh
setopt EXTENDED_GLOB
for filepath in $HOME/.dotFiles/files/*; do
	local filename=${filepath:t}
	mv $HOME/.$filename $HOME/.$filename.bak
	ln -s $filepath $HOME/.$filename
done

if [ ! -e $HOME/.vim/bundle ]; then
	mkdir ~/.vim/bundle
else
	echo 'already make bundle'
fi
if [ ! -e $HOME/.vim/bundle/neobundle.vim ]; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else
	echo 'already git clone neobundle.vim'
fi
