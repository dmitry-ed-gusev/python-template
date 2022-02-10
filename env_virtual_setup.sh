#!/usr/bin/env bash
###############################################################################
#
#   Development environment setup script. Script can be used to re-create
#   development environment from 'scratch'.
#
#   Warning: script must be used (run) from shell, not from the virtual
#            environment (pipenv shell).
#
#   Created:  Dmitrii Gusev, 30.01.2022
#   Modified: Dmitrii Gusev, 09.02.2022
#
###############################################################################


# -- verbose output mode
VERBOSE="--verbose"
# -- set up encoding/language
export LANG='en_US.UTF-8'
BUILD_DIR='build/'
DIST_DIR='dist/'
# -- local ipykernel name
IPYKERNEL_NAME='python_template_ipkernel'

clear
printf "Development Virtual Environment setup is starting...\n\n"

# -- upgrade pip
printf "\nUpgrading pip.\n"
pip --no-cache-dir install --upgrade pip

# -- upgrading pipenv (just for the case)
printf "\nUpgrading pipenv.\n"
pip --no-cache-dir install --upgrade pipenv

# -- remove existing virtual environment, clear caches
printf "\nDeleting virtual environment and clearing caches.\n"
pipenv --rm ${VERBOSE}
pipenv --clear ${VERBOSE}

# -- clean build and distribution folders
printf "\nClearing temporary directories.\n"
printf "\nDeleting [%s]...\n" ${BUILD_DIR}
rm -r ${BUILD_DIR}
printf "\nDeleting [%s]...\n" ${BUILD_DIR}
rm -r ${DIST_DIR}

# -- removing Pipfile.lock (re-generate it)
printf "\nRemoving Pipfile.lock\n"
rm Pipfile.lock

# -- install all dependencies, incl. development
printf "\nInstalling dependencies, updating all + outdated.\n"
pipenv install --dev ${VERBOSE}

# -- install local ipykernel
printf "\nInstalling local ipykernel + check\n"
pipenv run ipython kernel install --user --name=${IPYKERNEL_NAME}
# -- list installed ipykernels
jupyter kernelspec list
sleep 5

# -- update all + outdated
# todo: do we need these updates?
#pipenv update --clear --outdated ${VERBOSE}

# - check for vulnerabilities and show dependencies graph
printf "\nChecking virtual environment for vulnerabilities.\n"
pipenv check
pipenv graph

# - outdated packages report
printf "\n\nOutdated packages list (pip list):\n"
pipenv run pip list --outdated
