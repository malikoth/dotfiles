#!/usr/bin/env python3

import sys
import os

from math import *
from random import *
from decimal import Decimal
from pprint import pprint as pp

import importlib
from inspect import getargspec
import argparse


class Argument:
    def __init__(self, name, nick, default):
        self.name = name
        self.nick = nick
        self.default = default
        self.description = ''

    def get_args(self):
        if self.default is not None:
            return '-' + self.nick, '--' + self.name
        else:
            return self.name,

    def get_kwargs(self):
        kwargs = {'help': self.description}

        if self.default is not None:
            kwargs['default'] = self.default

            if isinstance(self.default, bool):
                kwargs['action'] = 'store_true'
            else:
                kwargs.update({'nargs': '?', 'const': True, 'type': type(self.default)})

        return kwargs


def autocli(func):
    def _autocli(*args, **kwargs):
        args = list(args)
        nicks = {}
        signature_args = getargspec(func)[0]

        # Generate one-letter nicknames for each argument requested
        for arg in signature_args:
            if len(arg) <= 1:
                continue

            for letter in arg:
                if letter.lower() not in nicks:
                    nicks[letter.lower()] = arg
                    break

                if letter.upper() not in nicks:
                    nicks[letter.upper()] = arg
                    break

        # Parse the parameters passed in with argparse
        docs = (func.__doc__ if func.__doc__ else '').split('\n')
        requested = getargspec(func)[0] or []
        defaults = getargspec(func)[3] or []
        reverse_nicks = {v: k for k, v in nicks.items()}
        arguments = {}

        name, _, _ = sys.argv[0].rpartition('.')
        description = ''
        if not docs[0].startswith(' '):
            description = '\n'.join(filter(lambda x: ':' not in x, docs))
            docs = filter(lambda x: ':' in x, docs)

        for i, arg in enumerate(requested):
            arguments[arg] = Argument(
                arg,
                reverse_nicks.get(arg, ''),
                defaults[i - len(requested)] if i >= len(requested) - len(defaults) else None
            )
        for line in docs:
            argname, _, help_text = line.strip().partition(':')
            if argname and help_text:
                arguments[argname].description = help_text.strip()

        parser = argparse.ArgumentParser(
            description=description,
            formatter_class=argparse.ArgumentDefaultsHelpFormatter,
            argument_default=argparse.SUPPRESS,
        )

        for arg in arguments.values():
            parser.add_argument(*arg.get_args(), **arg.get_kwargs())
        parsed_args, unknown = parser.parse_known_args()
        sys.argv = sys.argv[0:1] + unknown

        kwargs.update({k: v for k, v in vars(parsed_args).items() if v != arguments[k].default})

        return func(*args, **kwargs)

    return _autocli


@autocli
def main(collections=False, csv=False, datetime=False, re=False, shutil=False, zlib=False):
    """Python Calculator - Comprehensive command line interface to python expressions.

    Batteries included!  Imports os, sys, math.*, random.*, Decimal, and pprint as pp.

    Also includes additional modules based on the following switches.
    """
    for k, v in locals().items():
        if v:
            globals().update(importlib.import_module(k).__dict__)

    try:
        result = eval(''.join(sys.argv[1:]), globals(), {})
        if result:
            print(result)
    except Exception:
        exec(''.join(sys.argv[1:]), globals(), {})

if __name__ == '__main__':
    main()
