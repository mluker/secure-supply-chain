FROM --platform=linux/amd64 mcr.microsoft.com/vscode/devcontainers/base:bullseye

# Scanning Tools
ARG TRIVY_VERSION=0.37.3
RUN curl -Lo trivy.tar.gz https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz \
    && tar -zxf trivy.tar.gz -C /usr/local/bin trivy \
    && rm -rf trivy.tar.gz

ARG GRYPE_VERSION=0.57.1
RUN curl -Lo grype.tar.gz https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz \
    && tar -zxf grype.tar.gz -C /usr/local/bin grype \
    && rm -rf grype.tar.gz

# SBOM Tools
ARG SYFT_VERSION=0.73.0
RUN curl -Lo syft.tar.gz https://github.com/anchore/syft/releases/download/v${SYFT_VERSION}/syft_${SYFT_VERSION}_linux_amd64.tar.gz \
    && tar -zxf syft.tar.gz -C /usr/local/bin syft \
    && rm -rf syft.tar.gz

ARG MS_SBOM_TOOL=0.3.1
RUN curl -Lo sbom-tool-linux-x64 https://github.com/microsoft/sbom-tool/releases/download/v${MS_SBOM_TOOL}/sbom-tool-linux-x64 \
    && chmod +x sbom-tool-linux-x64 \
    && mv sbom-tool-linux-x64 /usr/local/bin/sbom-tool