cd $HOME
mkdir .homebrew
curl -Lsf http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C ./.homebrew/
ls .homebrew/

#  vi ~/.profile  # or .bash_profile etc
# echo 'export HOMEBREW=~/.homebrew' >> .zprofile
# echo 'export PATH=$HOME/bin:$HOMEBREW/bin:$HOMEBREW/share/python:$PATH' >> .zprofile
# echo 'export MANPATH=$MANPATH:$HOMEBREW/share/man' >> .zprofile

# source ~/.zprofile
# echo $HOMEBREW

brew install git
cd /tmp
git clone http://github.com/mxcl/homebrew.git homebrew
mv homebrew/.git ~/.homebrew/
rm -rf /tmp/homebrew

cd ~/.homebrew
git status
brew update


# completion for zsh
ln -snfv ~/.homebrew/Library/Contributions/brew_zsh_completion.zsh ~/.homebrew/share/zsh/site-functions/_brew
