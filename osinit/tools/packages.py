#! /usr/bin/env python

from subprocess import check_output

LINUX = "Linux"
MAC = "Darwin"

PACKAGES = {
    'Silver Searcher': ('silversearcher-ag', 'ag'),
    'ditaa': 'ditaa',
    'dtrx': 'dtrx',
    'git': 'git',
    'graphviz': 'graphviz',
    'htop': 'htop',
    'httpie': 'httpie',
    'iftop': 'iftop',
    'invoke': 'invoke',
    'inxi': 'inxi',
    'irssi': 'irssi',
    'm4': 'm4',
    'ncdu': 'ncdu',
    'pwgen': 'pwgen',
    'ranger': 'ranger',
    'tree': 'tree',
    'w3m': 'w3m',
    'wavemon': 'wavemon',
    'xclip': ('xclip', None),
    'z': 'z'
}


def get_packages(system):
    return 'xclip'
    return ' '.join(filter(None, (v if not isinstance(v, tuple) else v[0 if system == LINUX else 1] for k, v in PACKAGES)))


def run(command):
    return check_output(command.split())


def main():
    system = run("uname -s")

    if system == "Darwin":
        pass

    elif system == "Linux":
        run('sudo apt-get update')
        run('sudo apt-get upgrade')

        run('sudo apt-get install -y {}'.format(get_packages(system)))


if __name__ == '__main__':
    main()
