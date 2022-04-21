#!/usr/bin/env bash

###############################################################################
#
#   Build and test script for [PROJECT NAME] project.
#   Script can be run from outside of virtual (pipenv) environment (from the
#   system shell) and from the pipenv environment as well (pipenv shell).
#
#   Created:  Dmitrii Gusev, 30.01.2022
#   Modified: Dmitrii GUsev, 21.04.2022
#
###############################################################################

# todo: review the script and apply where necessary
# todo: do put output of utilities - mypy/black/flake8 - to a separated file(s)?

# -- safe bash scripting
set -euf -o pipefail

# -- verbose output mode
VERBOSE="--verbose"
# -- set up encoding/language
export LANG="en_US.UTF-8"
# -- build directories
BUILD_DIR='build/'
DIST_DIR='dist/'

echo
echo "Build is starting..."
echo

# -- clean build and distribution folders
echo "Clearing temporary directories."
echo "Deleting ${BUILD_DIR}..."
rm -r "${BUILD_DIR}"
echo "Deleting ${DIST_DIR}..."
rm -r "${DIST_DIR}"

# -- clean caches and sync + lock pipenv dependencies (update from the file Pipfile.lock)
pipenv clean ${VERBOSE}
pipenv update ${VERBOSE}
# -- update outdated dependencies (optional)
#pipenv update --outdated

# -- run pytest with pytest-cov (see pytest.ini/setup.cfg - additional parameters)
pipenv run pytest tests/

# -- run mypy - types checker
pipenv run mypy src/
pipenv run mypy tests/

# -- run black code formatter
pipenv run black src/ --verbose --line-length 110
pipenv run black tests/ --verbose --line-length 110

# -- run flake8 for checking code formatting
pipenv run flake8 src/
pipenv run flake8 tests/

# -- build two distributions: binary (whl) and source (tar.gz)
pipenv run python -m build
