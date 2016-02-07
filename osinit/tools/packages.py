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
            self.output()

            return manager

    def update_all(self):
        self.output('Updating and upgrading packages...')
        if self.manager == 'apt-get':
            self.run('sudo apt-get update', stream=True)
            self.run('sudo apt-get -y upgrade', stream=True)
        elif self.manager == 'brew':
            self.run('brew update', stream=True)
            self.run('brew upgrade --all', stream=True)
            self.run('brew cleanup', stream=True)

        # TODO: Rest of the package managers, as needed

        self.output('Update / upgrade process complete')
        self.output()

    def ensure_git(self):
        self.output('Ensuring git is installed...')
        if self.run('git') == 127:
            self.output('Installing git...')
            self.install('git')

        self.output()

    def install(self, package):
        sudo = self.manager != 'brew'
        git = package.endswith('.git')

        self.output('Installing {}...'.format(package))
        if git:
            os.chdir('/opt')
            output = self.run('git clone {}'.format(package), stream=True)
        else:
            output = self.run('{} {} install -y {}'.format('sudo' if sudo else '', self.manager, package), stream=True)

        if isinstance(output, int) and output != 0:
            self.output('Failed installing {}'.format(package))
        else:
            self.output('Success installing {}'.format(package))
        self.output()

    def output(self, *args, **kwargs):
        if self.args.verbose:
            if args:
                print(*args, **kwargs)
            else:
                print(**kwargs)

    def run(self, command, stream=False):
        self.output('Executing command:', command)
        output = []
        try:
            process = Popen(command.split(), stdout=PIPE)
            for line in iter(process.stdout.readline, ''):
                output.append(line)
                if stream:
                    self.output('-->', line, end='')

            if not process.returncode:
                return ''.join(output)
            else:
                return process.returncode

        except OSError as ose:
            self.output("Error:", ose.message())
            return 1

    def main(self):
        for project, package in self.packages.iteritems():
            if isinstance(package, dict):
                package = package.get(self.manager, '')

            if package:
                self.install(package)


if __name__ == '__main__':
    Packages()
