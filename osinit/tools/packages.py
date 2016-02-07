#! /usr/bin/env python

from __future__ import print_function

import argparse
import json
import os
from subprocess import Popen, PIPE

PACKAGE_MANAGERS = ('apt-get', 'brew', 'emerge', 'pacman', 'yum', 'zypp', 'pip', 'pip3', 'git')
PACKAGE_FILE = 'packages.json'

RED = '\x1b[31m'
GREEN = '\x1b[32m'
BRIGHT_RED = '\x1b[31;1m'
BRIGHT_GREEN = '\x1b[32;1m'
GRAY = '\x1b[30;1m'
RESET = '\x1b[0m'


class Packages:
    """
    Install listed packages per OS
    """

    def __init__(self):
        self.args = self.parse_args()
        self.packages = json.load(open(self.args.package_file if self.args.package_file else PACKAGE_FILE))

        if not self.args.skip_update:
            self.update_all()

        self.ensure_managers()
        self.managers = self.find_package_managers()
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

            self.output(BRIGHT_GREEN + 'Found package manager:', manager, RESET)
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

    def ensure_managers(self):
        self.output('Ensuring git is installed...')
        if self.run('git') == 127:
            self.output('Installing git...')
            self.install('git')

        self.output('Ensuring pip is installed...')
        if self.run('pip') == 127:
            self.output('Installing pip...')
            self.install('python-pip')

        self.output('Ensuring pip3 is installed...')
        if self.run('pip3') == 127:
            self.output('Installing pip3...')
            self.install('python3-pip')

        self.output()

    def install(self, package, manager=None):
        manager = manager or self.managers[0]
        sudo = manager != 'brew'
        confirm_flag = '-y' if manager == 'apt-get' else ''

        self.output('Installing {}...'.format(package), force=True)
        if manager == 'git':
            os.chdir('/opt')
            output = self.run('git clone {}'.format(package), stream=True)
        else:
            output = self.run('{} {} install {} {}'.format('sudo' if sudo else '',
                                                           manager, confirm_flag, package), stream=True)

        if isinstance(output, int) and output != 0:
            self.output('{}Failed installing {}{}'.format(BRIGHT_RED, package, RESET), force=True)
        else:
            self.output('{}Success installing {}{}'.format(BRIGHT_GREEN, package, RESET), force=True)
        self.output()

    def output(self, *args, **kwargs):
        if kwargs.pop('force', False) or self.args.verbose:
            if args:
                print(*args, **kwargs)
            else:
                print(**kwargs)

    def run(self, command, stream=False):
        self.output(GRAY + 'Executing command:', command, RESET)
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
            self.output(RED + "Error:", ose, RESET)
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
