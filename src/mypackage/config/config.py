#!/usr/bin/env python3
# coding=utf-8

"""
    Configuration file.

    Created:  Gusev Dmitrii, 07.06.2022
    Modified:
"""

import os
import json
from pathlib import Path
from dataclasses import asdict
from dataclasses import dataclass

MSG_MODULE_ISNT_RUNNABLE: str = "This module is not runnable!"
# todo: adjust the name of cache dir
CACHE_DIR_NAME: str = ".template-project"  # cache/tmp dir name


# if cache is in curr dir (exists and is dir) - use it, otherwise - use the user
# home directory (mostly suitable for development, in most cases user home dir will be used)
def get_cache_dir(base_name: str) -> str:
    if not base_name:
        raise ValueError("Empty base name!")

    if Path(base_name).exists() and Path(base_name).is_dir():
        return base_name
    else:  # cache dir not exists or is not a dir
        return str(Path.home()) + '/' + base_name


def singleton(class_):
    instances = {}

    def getinstance(*args, **kwargs):
        if class_ not in instances:
            instances[class_] = class_(*args, **kwargs)
        return instances[class_]
    return getinstance


@singleton
@dataclass(frozen=True)
class Config():
    # -- useful defaults
    encoding: str = "utf-8"
    app_name: str = "Template Project"  # todo: template project name

    # -- library directories
    cache_dir: str = get_cache_dir(CACHE_DIR_NAME)
    work_dir: str = str(os.getcwd())
    user_dir: str = str(Path.home())
    log_dir: str = cache_dir + "/logs"

    # -- project-related settings
    # todo: add settings here

    def __post_init__(self):  # post-init makes sure all logging dirs exist
        os.makedirs(str(self.log_dir), exist_ok=True)

    def __repr__(self):
        return "Config: " + json.dumps(asdict(self), sort_keys=True, indent=4)


if __name__ == "__main__":
    print(MSG_MODULE_ISNT_RUNNABLE)
