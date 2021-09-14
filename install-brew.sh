#! /bin/zsh

ARCH=`arch`
DIRNAME=".homebrew_$ARCH"

cd $HOME
echo "Install homebrew to ~/.homebrew_$ARCH"
mkdir $DIRNAME
curl -Lsf https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ./$DIRNAME/
ls -alh .homebrew/

#### vi ~/.profile  # or .bash_profile etc
# echo "Export path to ~/.homebrew/bin"
# 
# echo 'export HOMEBREW=~/.homebrew' >> .zprofile
# echo 'export PATH=$HOME/bin:$HOMEBREW/bin:$HOMEBREW/share/python:$PATH' >> .zprofile
# echo 'export MANPATH=$MANPATH:$HOMEBREW/share/man' >> .zprofile
# 
# source ~/.zprofile

echo $HOMEBREW

echo "Upgrade git"
brew install git
cd /tmp
git clone https://github.com/Homebrew/brew.git homebrew
mv homebrew/.git ~/$DIRNAME/
rm -rf /tmp/homebrew

cd ~/$DIRNAME
git status
brew update

# brew bundle --file ~/.dotFiles/Brewfile
