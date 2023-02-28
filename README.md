# SBOM & Vulnerability scanning

Use the provided devcontainer to start working with SBOMs and Vulnerability scanners.

## Environment variables

Set the following environment variables for use within each tool

```bash
# The image to work with
IMAGE=nginx

# The root folder for the results output
RESULTS_FOLDER=results
```

## SBOM tooling

### Syft

```bash
syft $IMAGE -o spdx-json --file "${RESULTS_FOLDER}"/"$(echo syft_${IMAGE}.json | sed 's/://g;s/\///g;s/@//g')"
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
grype $IMAGE -o sarif --file "${RESULTS_FOLDER}"/"$(echo grype_${IMAGE}.json | sed 's/://g;s/\///g;s/@//g')"
```

### Trivy

```bash
trivy image $IMAGE -f sarif -o "${RESULTS_FOLDER}"/"$(echo trivy_${IMAGE}.json | sed 's/://g;s/\///g;s/@//g')"
```

# Bulk command
./generate-all.sh "nginx,busybox" true true true true results