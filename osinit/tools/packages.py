#! /usr/bin/env python

import argparse
import json
from subprocess import check_output, CalledProcessError

LINUX = 'Linux'
MAC = 'Darwin'
PACKAGE_MANAGERS = ('apt-get', 'brew', 'emerge', 'pacman', 'yum', 'zypp')
PACKAGE_FILE = 'packages.json'


def run(command):
    try:
        return check_output(command.split()).strip()
    except CalledProcessError:
        return False


class Packages:
    """
    Install listed packages per OS
    """

    def __init__(self):
        self.args = self.parse_args()
        self.system = run('uname -s')
        self.packages = json.load(open(self.args.package_file if self.args.package_file else PACKAGE_FILE))
        self.manager = self.find_package_manager()

        if not self.args.skip_update:
            self.update_all()
        self.ensure_git()
        self.main()

    def parse_args(self):
        parser = argparse.ArgumentParser(
            description=self.__doc__,
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument('-s', '--skip-update', action='store_true', help='Skip the package update / upgrade process')
        parser.add_argument('-p', '--package-file', required=False, help='JSON file containing list of packages to install')
        return parser.parse_args()

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
            return run('cd /opt && git clone {}'.format(package))
        else:
            return run('{} {} install -y {}'.format('sudo' if sudo else '', self.manager, package))

    def main(self):
        for project, package in self.packages.iteritems():
            print('Installing {}...'.format(project))

            if isinstance(package, dict):
                package = package.get(self.manager, '')

            if package:
                print(self.install(package))

            print('Installed {}...'.format(project))
            print('')


if __name__ == '__main__':
    Packages()
