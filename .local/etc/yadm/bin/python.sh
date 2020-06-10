#! /usr/bin/env sh

# Install and setup Python, pip, and install packages I like for Python

export PYENV_ROOT=$HOME/.local/opt/pyenv
curl https://pyenv.run | bash
ln -sf "$HOME/.local/opt/pyenv/bin/pyenv" "$HOME/.local/bin/pyenv"
PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

PYTHON_VERSION=$(pyenv install -l | grep -E " [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$" | tail -1)
pyenv install --skip-existing $PYTHON_VERSION
pyenv global $PYTHON_VERSION

pip install -U pip

pip install -r $HOME/.local/etc/packages/python_global.txt
pip install -r $HOME/.local/etc/packages/python_local.txt

for package in $(sed -e '/\s*#.*/d' $HOME/.local/etc/packages/python_tools.txt); do
    pipx install $package
done
