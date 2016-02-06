#! /usr/bin/env python

import json
from subprocess import check_output, CalledProcessError

LINUX = "Linux"
MAC = "Darwin"

PACKAGE_MANAGERS = ('apt-get', 'brew', 'emerge', 'pacman', 'yum', 'zypp')

PACKAGE_FILE = 'packages-short.json'


def run(command):
    try:
        return check_output(command.split()).strip()
    except CalledProcessError:
        return False


class Packages:
    def __init__(self):
        self.system = run('uname -s')
        self.packages = json.load(open(PACKAGE_FILE))
        self.manager = self.find_package_manager()
        self.update_all()
        self.ensure_git()
        self.main()

    def find_package_manager(self):
        for manager in PACKAGE_MANAGERS:
            if run(manager) is False:
                continue

            return manager

    def update_all(self):
        if self.manager == 'apt-get':
            run('sudo apt-get update')
            run('sudo apt-get -y upgrade')
        elif self.manager == 'brew':
            run('brew update')
            run('brew upgrade --all')
            run('brew cleanup')
        # TODO: Rest of the package managers, as needed

    def ensure_git(self):
        if run('git') is False:
            self.install('git')

    def install(self, package):
        sudo = self.manager != 'brew'
        git = package.endswith('.git')

        if git:
            run('cd /opt && git clone {}'.format(package))
        else:
            run('{} {} install -y {}'.format('sudo' if sudo else '', self.manager, package))

    def main(self):
        for project, package in self.packages.iteritems():
            print('Installing {}...'.format(project))

            if isinstance(package, dict):
                package = package.get(self.manager, '')

            if package:
                self.install(package)

            print('Installed {}...'.format(project))
            print()


if __name__ == '__main__':
    Packages()
