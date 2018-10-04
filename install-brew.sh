#! /bin/zsh

cd $HOME
echo "Install homebrew to ~/.homebrew"
mkdir .homebrew
curl -Lsf http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C ./.homebrew/
ls .homebrew/

#  vi ~/.profile  # or .bash_profile etc
echo "Export path to ~/.homebrew/bin"

echo 'export HOMEBREW=~/.homebrew' >> .zprofile
echo 'export PATH=$HOME/bin:$HOMEBREW/bin:$HOMEBREW/share/python:$PATH' >> .zprofile
echo 'export MANPATH=$MANPATH:$HOMEBREW/share/man' >> .zprofile

source ~/.zprofile
echo $HOMEBREW

echo "Upgrade git"
brew install git
cd /tmp
git clone http://github.com/mxcl/homebrew.git homebrew
mv homebrew/.git ~/.homebrew/
rm -rf /tmp/homebrew

cd ~/.homebrew
git status
brew update
