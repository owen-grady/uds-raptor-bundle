
1. Update [CHANGELOG.md](CHANGELOG.md)

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
