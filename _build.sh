#!/usr/bin/env bash

###############################################################################
#
#   Build and test script for [TEMPLATE PROJECT] project.
#   Script can be run from outside of virtual (pipenv) environment (from the
#   system shell) and from the pipenv environment as well (pipenv shell).
#
#   Created:  Dmitrii Gusev, 30.01.2022
#   Modified: Dmitrii GUsev, 07.06.2022
#
###############################################################################

# todo: review the script and apply where necessary

# -- safe bash scripting
set -euf -o pipefail

# -- set up encoding/language
export LANG="en_US.UTF-8"
# -- project name
PROJECT_NAME='TEMPLATE PROJECT'
# -- build directories
BUILD_DIR='build/'
DIST_DIR='dist/'
SRC_DIR='src/'
TEST_DIR='tests/'
# -- options for pipenv
OPTS_PIPENV="--verbose"
# -- options for mypy
OPTS_MYPY="-v"
# -- options for flake8
OPTS_FLAKE8="-v"

clear
printf "Building of the library [%s] is starting...\n\n" "${PROJECT_NAME}"

# -- clean build and distribution folders (delete them)
printf "\nClearing temporary directories.\n"
printf "\nDeleting [%s]...\n" ${BUILD_DIR}
rm -r ${BUILD_DIR} || printf "%s doesn't exist!\n" ${BUILD_DIR}
printf "\nDeleting [%s]...\n" ${DIST_DIR}
rm -r ${DIST_DIR} || printf "%s doesn't exist!\n" ${DIST_DIR}

# -- clean pipenv caches
printf "\nPipenv: clean environment.\n"
pipenv clean "${OPTS_PIPENV}"

# -- sync + lock pipenv dependencies (update from the file Pipfile.lock)
# pipenv update "${OPTS_PIPENV}""

# -- run pytest with pytest-cov (see pytest.ini/setup.cfg - additional parameters)
printf "\nExecuting pytests.\n"
pipenv run pytest ${TEST_DIR}

# -- run mypy - types checker
printf "\nExecuting mypy checker.\n"
pipenv run mypy ${OPTS_MYPY} ${SRC_DIR}
pipenv run mypy ${OPTS_MYPY} ${TEST_DIR}

# -- run black code formatter
# printf "\n\n"
# pipenv run black src/ --verbose --line-length 110
# pipenv run black tests/ --verbose --line-length 110

# -- run flake8 for checking code formatting
printf "\nExecuting flake8 checker.\n"
pipenv run flake8 ${OPTS_FLAKE8} ${SRC_DIR} || printf "There are issues in the [%s] directory!" ${SRC_DIR}
pipenv run flake8 ${OPTS_FLAKE8} ${TEST_DIR} || printf "There are issues in the [%s] directory!" ${TEST_DIR}

# -- build two distributions: binary (whl) and source (tar.gz)
printf "\nBuilding the library.\n"
pipenv run python -m build
