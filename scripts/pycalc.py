#!/usr/bin/env python3

import sys
import os

from math import *
from random import *
from decimal import Decimal
from pprint import pprint as pp

import importlib
import argparse


class PyCalc:
    def __init__(self):
        self.options, self.query = self.parse_args()
        self.calc()

    def parse_args(self):
        parser = argparse.ArgumentParser(
            description=self.calc.__doc__,
        )
        parser.add_argument('-c', '--collections', action='store_true')
        parser.add_argument('-C', '--csv', action='store_true')
        parser.add_argument('-d', '--datetime', action='store_true')
        parser.add_argument('-r', '--re', action='store_true')
        parser.add_argument('-s', '--shutil', action='store_true')
        parser.add_argument('-z', '--zlib', action='store_true')
        options, query = parser.parse_known_args()

        if not query:
            parser.print_help()
            sys.exit(0)
        else:
            return vars(options), ''.join(query)

    def calc(self):
        """Python Calculator - Comprehensive command line interface to python expressions.

        Batteries included!  Imports os, sys, math.*, random.*, Decimal, and pprint as pp.

        Also includes additional modules based on the following switches.
        """

        for k, v in self.options.items():
            if v:
                globals().update(vars(importlib.import_module(k)))

        try:
            result = eval(self.query, globals(), {})
            if result:
                print(result)
        except Exception:
            exec(self.query, globals(), {})


if __name__ == '__main__':
    PyCalc()
