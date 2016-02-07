#! /usr/bin/env python

from __future__ import print_function

import argparse
import json
import os
from subprocess import Popen, PIPE

PACKAGE_MANAGERS = ('apt-get', 'brew', 'emerge', 'pacman', 'yum', 'zypp', 'pip')
PACKAGE_FILE = 'packages.json'

RED = '\x1b[31m'
GREEN = '\x1b[32m'
BRIGHT_RED = '\x1b[31;1m'
BRIGHT_GREEN = '\x1b[32;1m'
RESET = '\x1b[0m'


# TODO: Add colored output
# TODO: Handle stderr pipes


class Packages:
    """
    Install listed packages per OS
    """

    def __init__(self):
        self.args = self.parse_args()
        self.packages = json.load(open(self.args.package_file if self.args.package_file else PACKAGE_FILE))
        self.managers = self.find_package_managers()

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

    def find_package_managers(self):
        managers = []
        for manager in PACKAGE_MANAGERS:
            if self.run(manager) == 127:
                continue

            self.output('Found package manager:', manager)
            managers.append(manager)

        self.output()
        return managers

    def update_all(self):
        self.output('Updating and upgrading packages...')
        if 'apt-get' in self.managers:
            self.run('sudo apt-get update', stream=True)
            self.run('sudo apt-get -y upgrade', stream=True)
        elif 'brew' in self.managers:
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

    def install(self, package, manager=None):
        manager = manager or self.managers[0]
        sudo = manager != 'brew'

        self.output('Installing {}...'.format(package))
        if manager == 'git':
            os.chdir('/opt')
            output = self.run('git clone {}'.format(package), stream=True)
        else:
            output = self.run('{} {} install -y {}'.format('sudo' if sudo else '', manager, package), stream=True)

        if isinstance(output, int) and output != 0:
            self.output('{}Failed installing {}{}'.format(BRIGHT_RED, package, RESET))
        else:
            self.output('{}Success installing {}{}'.format(BRIGHT_GREEN, package, RESET))
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
            process = Popen(command.split(), stdout=PIPE, stderr=PIPE)
            for line in iter(process.stdout.readline, ''):
                output.append(line)
                if stream:
                    self.output(GREEN + '   ', line, end=RESET)

            for line in iter(process.stderr.readline, ''):
                output.append(line)
                if stream:
                    self.output(RED + '   ', line, end=RESET)

            process.wait()
            if not process.returncode:
                return ''.join(output)
            else:
                return process.returncode

        except OSError as ose:
            self.output("Error:", ose)
            if ose.errno == 2:
                return 127
            return 1

    def main(self):
        for project, installers in self.packages.iteritems():
            if isinstance(installers, dict):
                for manager in self.managers:
                    if manager in installers:
                        package = installers[manager]
                        break

                if package:
                    self.install(package, manager)

            else:
                self.install(installers)


if __name__ == '__main__':
    Packages()
