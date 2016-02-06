#! /usr/bin/env python

from __future__ import print_function

import argparse
import json
import os
from subprocess import Popen, CalledProcessError, PIPE

PACKAGE_MANAGERS = ('apt-get', 'brew', 'emerge', 'pacman', 'yum', 'zypp')
PACKAGE_FILE = 'packages.json'


class Packages:
    """
    Install listed packages per OS
    """

    def __init__(self):
        self.args = self.parse_args()
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
        parser.add_argument('-v', '--verbose', action='store_true', help='Show verbose output')
        parser.add_argument('-p', '--package-file', required=False, help='JSON file containing list of packages to install')
        return parser.parse_args()

    def find_package_manager(self):
        for manager in PACKAGE_MANAGERS:
            if self.run(manager) == 127:
                continue

            self.output('Found package manager:', manager)
            return manager

    def update_all(self):
        self.output('Updating and upgrading packages...')
        if self.manager == 'apt-get':
            self.run('sudo apt-get update')
            self.run('sudo apt-get -y upgrade')
        elif self.manager == 'brew':
            self.run('brew update')
            self.run('brew upgrade --all')
            self.run('brew cleanup')
        # TODO: Rest of the package managers, as needed

    def ensure_git(self):
        self.output('Ensuring git is installed...')
        if self.run('git') == 127:
            self.output('Installing git...')
            self.install('git')

    def install(self, package):
        sudo = self.manager != 'brew'
        git = package.endswith('.git')

        self.output('Installing {}...'.format(package))
        if git:
            os.chdir('/opt')
            output = self.run('git clone {}'.format(package))
        else:
            output = self.run('{} {} install -y {}'.format('sudo' if sudo else '', self.manager, package))
        self.output('Installed {}...'.format(package))
        self.output()

        return output

    def output(self, *args, **kwargs):
        if self.args.verbose:
            if args:
                print('-->', *args, **kwargs)
            else:
                print(**kwargs)

    def run(self, command):
        self.output(command)
        output = []
        try:
            process = Popen(command.split(), stdout=PIPE)
            for line in iter(process.stdout.readline, ''):
                output.append(line)
                self.output(line, end='')
            return ''.join(output)
        except CalledProcessError as cpe:
            return cpe.returncode

    def main(self):
        for project, package in self.packages.iteritems():
            if isinstance(package, dict):
                package = package.get(self.manager, '')

            if package:
                print(self.install(package))


if __name__ == '__main__':
    Packages()