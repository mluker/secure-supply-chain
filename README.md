# SBOM & Vulnerability scanning

Use the provided devcontainer to start working with SBOMs and Vulnerability scanners.

## Environment variables

Set the following environment variables for use within each tool

```bash
# The image to work with
IMAGE=nginx:latest

# The root folder for the results output
RESULTS_FOLDER=results
```

## SBOM tooling

### Syft

```bash
syft $IMAGE --file $RESULTS_FOLDER/syft-results.txt -o syft-json
```

### Microsoft sbom-tool

```bash
export DeleteManifestDirIfPresent=true

sbom-tool generate -di $IMAGE \
    -b $RESULTS_FOLDER \
    -bc . \
    -pn package-name \
    -ps package-supplier \
    -nsb https://example.com \
    -pv 1
```

## Vulnerability scanning

### Grype

```bash
grype $IMAGE --file $RESULTS_FOLDER/grype-results.txt -o sarif
```

### Trivy

```bash
trivy image $IMAGE -o $RESULTS_FOLDER/trivy-results.txt -f sarif
```