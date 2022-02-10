# Python Template Repository

(C) 2022, Dmitrii Gusev

## Description

Use this repository as template for python projects. Ideal for various utilities/libraries. For
the web-projects this template should be adjusted a bit more.

## Repository Content

- [[docker](docker)] - folder with Docker files for various DBs
  - [docker-compose-mssql.yml](docker/docker-compose-mssql.yml) - TBD
  - [docker-compose-mysql.yml](docker/docker-compose-mysql.yml) - TBD
  - [docker-compose-postgres.yml](docker/docker-compose-postgres.yml) - TBD
- [[docs](docs)] - documantation catalog
- [[jupyter](jupyter)] - jupyter playbooks catalog
- [[tests](tests)] - unit/integration tests catalog
- [.coveragerc](.coveragerc) - TBD
- [.gitattributes](.gitattributes) - TBD
- [.gitignore](.gitignore) - TBD
- [.pre-commit-config.yaml](.pre-commit-config.yaml) - TBD
- [build.sh](build.sh) - TBD
- [env_python_setup.sh](env_python_setup.sh) - TBD
- [env_virtual_setup.sh](env_virtual_setup.sh) - TBD
- [LICENSE](LICENSE) - TBD
- [Pipfile](Pipfile) - TBD
- [pytest.ini](pytest.ini) - TBD
- [README.md](README.md) - this documentation
- [setup.cfg](setup.cfg) - main configuration file for the project
- [setup.py](setup.py) - dummy setup file for setuptools, necessary meta-information moved to setup.cfg

Adjust this template as necessary. If you don't need any files - remove them after creating your repository from this template.

## Repository Usage

Review the content and adjust as needed. Here are some advice, what may be useful:

- [docker] - use docker files as needed
- .gitignore** - file should cover most of the cases for python project, but some adjustments may be required
- build.sh - TBD
- env_virtual_setup.sh - TBD
- Pipfile - TBD
- README.md - definitely, you will write your own documentation :)
- setup.cfg - TBD

### Local Installation of the code

In order to install the current package/source code locally, add the following line to the Pipfile in the section [packages]:  

`<your_package_name> = {editable = true, path = "."}`
