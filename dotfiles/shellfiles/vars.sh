# Local vars

# Global vars
# TODO: Make PATH specific to which shell or box I'm on
export PATH="$HOME/bin:$HOME/dev/misc/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/X11/bin"
export EDITOR='vim'
export GREP_OPTIONS='--color=auto'
export CLICOLOR='1'
export LSCOLORS='GxFxCxDxBxegedabagaced'

case $( uname -s ) in
    Darwin ) # Mac
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$(man -w)"

        ## Packer / Vagrant
        #export DTWEB_USE_DT20DBEXPC_ORAXE_BOX='1'
        export DT20_VBOX_DIR='~/dev/boxes'
        export DT20_PROVISION_FILES_DIR='~/dev/dt20-devbox/files'
        export DT20_DEVELOP_DIR='~/dev'
        export BOX_DIR=~/dev/boxes
        export UBUNTU_1404_SERVER_ISO_PATH=~/Downloads/ISOs/ubuntu-14.04.3-server-amd64.iso
        export UBUNTU_1404_SERVER_ISO_CHKSUM=0501c446929f713eb162ae2088d8dc8b6426224a
esac
