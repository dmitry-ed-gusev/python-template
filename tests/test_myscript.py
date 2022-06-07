#!/usr/bin/env python3
# coding: utf–8

"""
    Unit tests for myscript module.

    Created:  Dmitrii Gusev, 07.06.2022
    Modified:
"""

from mypackage.myscript import check


def test_check():
    assert check(10) == 20
