#!/usr/bin/env python3
# coding=utf-8

"""
    Logging configuration for the application.
    See useful python logging resources:
      - https://docs.python.org/3/howto/logging.html#library-config

    Created:  Dmitrii Gusev, 07.06.2022
    Modified:
"""

# todo: adjust import here
from mypackage.config.config import MSG_MODULE_ISNT_RUNNABLE, Config

# init config instance and create necessary dirs (see the Config class)
config = Config()

LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": True,
    "formatters": {
        "standard": {  # standard log format
            "format": "%(asctime)s [%(levelname)s] %(name)s: %(message)s"
        },
        "simple": {  # usually used log format
            "format": "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        },
    },  # end of formatters block
    "handlers": {
        "default": {  # default handler (for emergency cases)
            "level": "DEBUG",
            "formatter": "standard",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stdout",  # Default is stderr
        },
        "console": {  # usual console handler
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "simple",
            "stream": "ext://sys.stdout",
        },
        "std_file_handler": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "DEBUG",
            "formatter": "simple",
            "filename": config.log_dir + "/log_info.log",
            "maxBytes": 10485760,  # 10MB
            "backupCount": 20,
            "encoding": config.encoding,
        },
        "error_file_handler": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "ERROR",
            "formatter": "simple",
            "filename": config.log_dir + "/log_errors.log",
            "maxBytes": 10485760,  # 10MB
            "backupCount": 20,
            "encoding": config.encoding,
        },
    },  # end of handlers block
    "loggers": {
        "rallytool": {
            # 'handlers': ['default'],
            "level": "DEBUG",
            # 'propagate': False
        },
        "pylib": {"level": "DEBUG"},
        "__main__": {  # if __name__ == '__main__' - emergency case
            "handlers": ["default"],
            "level": "DEBUG",
            "propagate": False,
        },
    },  # end of loggers module
    "root": {  # root logger
        "level": "INFO",
        "handlers": ["console", "std_file_handler", "error_file_handler"],
    },
}


if __name__ == "__main__":
    print(MSG_MODULE_ISNT_RUNNABLE)
