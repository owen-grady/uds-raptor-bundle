
1. Update [CHANGELOG.md](CHANGELOG.md)

# RKE2 Installation

The Raptor team heavily leverages Ansible of part of their infrastructure.  Rancher maintains an [Ansible playbook to install RKE2](https://github.com/rancherfederal/rke2-ansible) that we will use in both the EDN and Raptor environments.  This playbook exists as a git submodule in the top level `rke2-ansible` folder.

If needed, create an inventory file for the environment that you are working in:

```bash
cp -R rke2-ansible/inventory/sample infra/ansible/inventory/<<EDN|raptor>>
```

Update the inventory file with IP addresses/hostnames as per the environment.

In the EDN and Raptor environments, a custom `ansible.cfg` file is needed in order for the playbook to be able to run:

```cfg
[defaults]
home=/tmp/${USER}/.ansible
remote_tmp=/tmp/${USER}/ansible

```

When calling a playbook manually, the `ansible.cfg` file in the `infra/ansible` needs to be referenced in some way.  The easiest way is to export it as an environmental variable.  From the root of the repo, run:

```bash
export ANSIBLE_CONFIG=$(pwd)/infra/ansible/ansible.cfg
```

Alternatively, a `make` target exits to deploy RKE2 to the EDN:

```bash
make rke2-install
```

The `rke2-install` make target will update the `rke2-ansible` git submodule imported into this repo and download the latest RKE2 tarballs and place them in `<<repo-root>>/rke2-ansible/tarball_install`.  This location is where the Ansible playbook will look for the install media in order to perform an air gap install.

# UDS Bundle Raptor

The Raptor UDS Bundle is a packaging of components to provide a Kubernetes Secure Runtime for an on-premise environment.

## Prerequisites

- [UDS CLI](https://github.com/defenseunicorns/uds-cli/tree/v0.0.7-alpha) `brew install uds` or download direct from [GitHub](https://github.com/defenseunicorns/uds-cli/releases)

## Create

Switch into the `rke2-bundle` directory:

```bash
cd rke2-bundle
```

Then create the bundle:

```bash
uds create .
```

## Deploy

The `create` step writes a UDS bundle to disk that needs to be referenced in the `deploy` step:

```bash
uds deploy uds-bundle-raptor-uds-amd64-x.y.z.tar.zst
```

## Remove

```bash
uds remove uds-bundle-raptor-uds-amd64-x.y.z.tar.zst
```
