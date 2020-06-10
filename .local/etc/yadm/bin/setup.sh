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
git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.local/etc/zsh/.zprezto
zsh $HOME/.local/etc/yadm/bin/prezto.zsh || true
$SUDO chsh -s $(which zsh) $(whoami) &> /dev/null


# Install YADM
git clone https://github.com/TheLocehiliosan/yadm.git $HOME/.local/opt/yadm
ln -fs $HOME/.local/opt/yadm/yadm $HOME/.local/bin/yadm
$HOME/.local/bin/yadm alt
if ssh-add -l 2>&1 | grep -q 'klr'; then
    $HOME/.local/bin/yadm remote set-url origin git@git.klr.blue:kyle/dotfiles.git
else
    $HOME/.local/bin/yadm remote add origin-ssh git@git.klr.blue:kyle/dotfiles.git
fi


# Apply "Assume unchanged" rules to yadm repo
while read file; do
    $HOME/.local/bin/yadm update-index --assume-unchanged $HOME/$file
done < $HOME/.local/etc/git/assume-unchanged
