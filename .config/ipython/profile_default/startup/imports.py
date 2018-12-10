import collections
import contextlib
import csv
from datetime import date, datetime, timedelta
import functools
import hashlib
import itertools
import io
import json
import math
import os
import random
import re
import sys
import time

@contextlib.contextmanager
def imports():
    try:
        yield
    except ImportError:
        pass

with imports():
    from mock import Mock, MagicMock, patch, sentinel

if os.getenv('DJANGO_SETTINGS_MODULE'):
    with imports():
        from all import *
