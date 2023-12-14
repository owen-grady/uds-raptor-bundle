
1. Update [CHANGELOG.md](CHANGELOG.md)

# RKE2 Installation

The Raptor team heavily leverages Ansible of part of their infrastructure.  Rancher maintains an [Ansible playbook to install RKE2](https://github.com/rancherfederal/rke2-ansible) that we will use in both the EDN and Raptor environments.

To use this playbook, do the following:

Clone it:

```bash
git clone https://github.com/rancherfederal/rke2-ansible.git
```

Create an inventory file for the environment that you are working in:

```bash
cp -R inventory/sample inventory/<<EDN|raptor>>
```

Update the inventory file with IP addresses/hostnames as per the environment.

In the EDN and Raptor environments, a custom `ansible.cfg` file is needed in order for the playbook to be able to run:

```

```

Put this file alongside the `site.yml` playbook that will be called in the following step.

Then actually call the playbook:

```bash
ansible-playbook -b -k -K -i inventory/<<EDN|raptor>>.yaml site.yaml
```



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
uds bundle create
```

## Deploy

The `create` step writes a UDS bundle to disk that needs to be referenced in the `deploy` step:

```bash
uds deploy uds-bundle-raptor-uds-amd64-0.0.1.tar.zst
```

## Remove

```bash
uds remove uds-bundle-raptor-uds-amd64-0.0.1.tar.zst
```
