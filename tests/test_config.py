#!/usr/bin/env python3
# coding: utf–8

"""
    Rally Tool unit tests for config module.

    Created:  Dmitrii Gusev, 07.06.2022
    Modified:
"""

import pytest
from pathlib import Path
from mypackage.config.config import get_cache_dir


def test_get_cache_dir_empty_base_name():
    with pytest.raises(ValueError):
        get_cache_dir('')


def test_get_cache_dir_local_existing_dir(mocker):

    def mock_return_true(value: str):
        return True

    mocker.patch.object(Path, 'exists', mock_return_true)
    mocker.patch.object(Path, 'is_dir', mock_return_true)

    assert get_cache_dir('local_existing_dir') == 'local_existing_dir'


def test_get_cache_dir_local_non_existing_dir(mocker):

    def mock_return_false(value: str):
        return False

    def mock_return_dir():
        return '/abc'

    mocker.patch.object(Path, 'exists', mock_return_false)
    mocker.patch.object(Path, 'is_dir', mock_return_false)
    mocker.patch.object(Path, 'home', mock_return_dir)

    assert get_cache_dir('local_non_existing_dir') == '/abc/local_non_existing_dir'
