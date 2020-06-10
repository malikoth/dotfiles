#! /usr/bin/env sh

# Setup and initialize misc things.  All of this should be local to my home directory and non-destructive,
# even on a remote server


if [ "$(id -u)" != "0" ] && command -v sudo &> /dev/null; then
    SUDO=sudo
fi


# Initialize Vim plugins
if command -v vim &> /dev/null; then
  vim +PlugUpdate +PlugClean! +qall &> /dev/null
fi


# Setup ZSH / Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git $XDG_CONFIG_HOME/zsh/.zprezto
zsh $XDG_CONFIG_HOME/yadm/bin/prezto.zsh || true
$SUDO chsh -s $(which zsh) $(whoami) &> /dev/null


# Install YADM
git clone https://github.com/TheLocehiliosan/yadm.git $XDG_OPT_HOME/yadm
ln -fs $XDG_OPT_HOME/yadm/yadm $XDG_LOCAL_HOME/bin/yadm
$XDG_LOCAL_HOME/bin/yadm alt
if ssh-add -l 2>&1 | grep -q 'klr'; then
    $XDG_LOCAL_HOME/bin/yadm remote set-url origin git@git.klr.blue:kyle/dotfiles.git
else
    $XDG_LOCAL_HOME/bin/yadm remote add origin-ssh git@git.klr.blue:kyle/dotfiles.git
fi


# Apply "Assume unchanged" rules to yadm repo
while read file; do
    $XDG_LOCAL_HOME/bin/yadm update-index --assume-unchanged $HOME/$file
done < $XDG_CONFIG_HOME/git/assume-unchanged
