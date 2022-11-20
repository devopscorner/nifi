# Ansible Role: christiangda.awscli

[![Master branch workflow](https://github.com/christiangda/ansible-role-awscli/actions/workflows/master.yaml/badge.svg?branch=master)](https://github.com/christiangda/ansible-role-awscli/actions/workflows/master.yaml)
[![Develop branch workflow](https://github.com/christiangda/ansible-role-awscli/actions/workflows/develop.yaml/badge.svg?branch=develop)](https://github.com/christiangda/ansible-role-awscli/actions/workflows/develop.yaml)
[![Ansible Role](https://img.shields.io/ansible/role/40514.svg)](https://galaxy.ansible.com/christiangda/awscli)

This role [install AWS Command Line Interface (awscli)](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)

The best way to install this role is using the command `ansible-galaxy install christiangda.awscli`, the Ansible Galaxy repository is [christiangda.awscli](https://galaxy.ansible.com/christiangda/awscli)

The repository code is [https://github.com/christiangda/ansible-role-awscli](https://github.com/christiangda/ansible-role-awscli)

**Notes:**

* This role does not allow to configure [AWS CLI profile (config and credentials)](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html), instead, it works together with the role [christiangda.awscli](https://galaxy.ansible.com/christiangda/awscli_configure) witch allow you configure it.

## Requirements

This role work on RedHat, CentOS, Debian and Ubuntu distributions

* RedHat
  * 7
  * 8
* CentOS
  * 7
  * 8
* Ubuntu
  * 16.*
  * 18.*
  * 20.*
  * 21.*
* Debian
  * stretch (9)
  * buster (10)
  * bullseye (11)

To see the compatibility matrix of Python vs. Ansible see the project [Travis-CI build matrix](https://travis-ci.org/christiangda/ansible-role-awscli)

## Role Variables

None

## Dependencies

* RedHat/CentOS
  * 6/7 [EPEL Repository](https://fedoraproject.org/wiki/EPEL)
  You need to enable EPEL repository, you could use my role: [christiangda.epel_repo](https://galaxy.ansible.com/christiangda/epel_repo) for this task.

**Note:** RedHat/CentOS 8 doesn't need EPEL Repository to use this role.

## Example Playbook

### RedHat/CentOS, Ubuntu and Debian

When you have RedHat/CentOS 8 or Debian/Ubuntu target

```yaml
- hosts: redhat-8
    gather_facts: True
    roles:
      - role: christiangda.awscli
```

When you have RedHat/CentOS 6/7 target

```yaml
- hosts: redhat-7
    gather_facts: True
    roles:
      - role: christiangda.epel_repo
      - role: christiangda.awscli
```

When you have multiples OS targets, install EPEL repository only in RedHat/CentOS 6/7

```yaml
- hosts: servers
    gather_facts: True
    roles:
    - role: christiangda.epel_repo
      when: >
        ansible_os_family == 'RedHat' and (
          ansible_distribution == 'CentOS' or
          ansible_distribution == 'RedHat'
        )
        and (
          ansible_distribution_major_version == '6' or
          ansible_distribution_major_version == '7'
        )
      changed_when: false
    - role: christiangda.awscli

```

**When you have RedHat/CentOS 8 or Debian/Ubuntu target** and wants to use the role [christiangda.awscli](https://galaxy.ansible.com/christiangda/awscli)

```yaml
- hosts: redhat-8
    gather_facts: True
    roles:
      - role: christiangda.awscli
      - role: christiangda.awscli_configure
        vars:
          awscliconf_files:
            credentials:
              - default:
                  aws_access_key_id: 'AKIAIOSFODNN7EXAMPLE'
                  aws_secret_access_key: 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
            config:
              - default:
                  region: us-west-2
                  output: json
              - profile development:
                  role_arn: 'arn:aws:iam::123456789012:role/role-for-development'
                  mfa_serial: 'arn:aws:iam::11111111111:mfa/christian.gonzalez'
                  region: eu-west-1
                  source_profile: default
```

## Development / Contributing

This role is tested using [Molecule](https://molecule.readthedocs.io/en/latest/) and was developed using
[Python Virtual Environments](https://docs.python.org/3/tutorial/venv.html)

Also, we used to main git branch

* master
* develop

If you want to contribute to this project what you want to do is

* [Fork the project](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
* [Prepare your environment](#prepare-your-environment)
* Fix the problem in `develop` branch
* Execute `molecule test`
* Create a Pull Request to official project `develop` branch

References

* [Fork a repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
* [Creating a pull request from a fork](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork)

### Prepare your environment

* Python 3

```bash
mkdir ansible-roles
cd ansible-roles/

python3 -m venv venv
source venv/bin/activate
pip install pip --upgrade
pip install ansible
pip install molecule
pip install 'molecule[docker]'
pip install 'molecule[lint]'
pip install molecule-vagrant
pip install python-vagrant
pip install selinux
pip install docker
pip install pytest
pip install pytest-mock
pip install pylint
pip install rope
pip install autopep8
pip install yamllint
pip install flake8
pip install ansible-lint
```

### Clone the role repository (From your fork) and create symbolic link

```bash
git clone https://github.com/christiangda/ansible-role-awscli.git
ln -s ansible-role-awscli christiangda.awscli
cd christiangda.awscli
```

### Execute the molecule test

Scenarios available:

* default --> `--driver-name docker` and only the latest version of OS
* docker --> `--driver-name docker`
* podman --> `--driver-name podman`
* vagrant --> `--driver-name vagrant`

#### scenario default

Step by step

```bash
molecule create [--scenario-name default]
molecule converge [--scenario-name default]
molecule verify [--scenario-name default]
molecule destroy [--scenario-name default]
```

or

All in one

```bash
molecule test [--scenario-name default]
```

#### scenario podman

Step by step

```bash
molecule create --scenario-name podman
molecule converge --scenario-name podman
molecule verify --scenario-name podman
molecule destroy --scenario-name podman
```

or

All in one

```bash
molecule test --scenario-name podman
```

#### scenario vagrant

Step by step

```bash
molecule create --scenario-name vagrant
molecule converge --scenario-name vagrant
molecule verify --scenario-name vagrant
molecule destroy --scenario-name vagrant
```

or

All in one

```bash
molecule test --scenario-name vagrant
```

**Additionally if you want to test it using VMs, I have a very nice [ansible-playground project](https://github.com/christiangda/ansible-playground) that use Vagrant and VirtualBox, try it!.**

## License

This module is released under the GNU General Public License Version 3:

* [http://www.gnu.org/licenses/gpl-3.0-standalone.html](http://www.gnu.org/licenses/gpl-3.0-standalone.html)

## Author Information

* [Christian González Di Antonio](https://github.com/christiangda)
