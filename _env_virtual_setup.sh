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
#   Modified: Dmitrii Gusev, 07.06.2022
#
###############################################################################

# -- safe bash scripting
set -euf -o pipefail

# -- verbose output mode
VERBOSE="--verbose"
# -- set up encoding/language
export LANG='en_US.UTF-8'
BUILD_DIR='build/'
DIST_DIR='dist/'
# -- local ipykernel name
IPYKERNEL_NAME='template_project_ipkernel'

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
pipenv --rm ${VERBOSE} || printf "No virtual environment fount for the project!\n"
pipenv --clear ${VERBOSE}

# -- clean build and distribution folders (delete them)
printf "\nClearing temporary directories.\n"
printf "\nDeleting [%s]...\n" ${BUILD_DIR}
rm -r ${BUILD_DIR} || printf "%s doesn't exist!\n" ${BUILD_DIR}
printf "\nDeleting [%s]...\n" ${DIST_DIR}
rm -r ${DIST_DIR} || printf "%s doesn't exist!\n" ${DIST_DIR}

# -- removing Pipfile.lock (re-generate it)
printf "\nRemoving Pipfile.lock\n"
rm Pipfile.lock || printf "Pipfile.lock doesn't exist!\n"

# -- install all dependencies, incl. development
printf "\nInstalling dependencies, updating all + outdated.\n"
pipenv install --dev ${VERBOSE}

# -- install local ipykernel
printf "\nInstalling local ipykernel + check\n"
pipenv run ipython kernel install --user --name=${IPYKERNEL_NAME}
# -- list installed ipykernels
jupyter kernelspec list
sleep 5

# - check for vulnerabilities and show dependencies graph
printf "\nChecking virtual environment for vulnerabilities.\n"
pipenv check
pipenv graph

# - outdated packages report
printf "\n\nOutdated packages list (pip list):\n"
pipenv run pip list --outdated
