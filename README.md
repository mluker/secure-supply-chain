# SBOM & Vulnerability scanning

Use the provided devcontainer to start working with SBOMs and Vulnerability scanners.

## Environment variables

Set the following environment variables for use within each tool

```bash
# The image to work with
IMAGE=cmacsbom101zda.azurecr.io/poi:20230224

# The root folder for the results output
RESULTS_FOLDER=results
```

## SBOM tooling

### Syft

```bash
syft $IMAGE -o syft-json --file "${RESULTS_FOLDER}"/${IMAGE}.txt | $(sed 's/://g;s/\.//g;s/\///g;s/@//g')
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