#!/bin/bash

# IMAGES: comma separated list of images to scan
# GEN_TRIVY: true/false
# GEN_GRYPE: true/false
# GEN_SYFT: true/false
# GEN_SBOMTOOL: true/false
# RESULTS_FOLDER: folder where the results will be stored

# Usage: ./generate-all.sh IMAGES GEN_TRIVY GEN_GRYPE GEN_SYFT GEN_SBOMTOOL RESULTS_FOLDER
# Example ./generate-all.sh "nginx" true false false false results

IMAGES=$1
GEN_TRIVY=$2
GEN_GRYPE=$3
GEN_SYFT=$4
GEN_SBOMTOOL=$5
RESULTS_FOLDER=$6
FILENAME_PATTERN='s/://g;s/\///g;s/@//g'

: ${IMAGES:=""}
: ${GEN_TRIVY:=false}
: ${GEN_GRYPE:=false}
: ${GEN_SYFT:=false}
: ${GEN_SBOMTOOL:=false}
: ${RESULTS_FOLDER:="results"}

for i in ${IMAGES//,/ }
do
    file="${RESULTS_FOLDER}"/"$(echo APPNAME_${i}.json | sed $FILENAME_PATTERN)"

    if $GEN_TRIVY; then
        trivy image $i -f sarif -o "$(echo $file | sed 's/APPNAME/trivy/g')"
    fi

    if $GEN_GRYPE; then
        grype $i -o sarif --file "$(echo $file | sed 's/APPNAME/grype/g')"
    fi

    if $GEN_SYFT; then
         syft $i -o spdx-json --file "$(echo $file | sed 's/APPNAME/syft/g')"
    fi

    if $GEN_SBOMTOOL; then
        export DeleteManifestDirIfPresent=true
        DIR="$(echo $file | sed 's/APPNAME/sbom/;s/.json//g')"
        mkdir $DIR
        sbom-tool generate -di $i -bc ./emptyfolder -pn package-name -ps package-supplier -nsb https://example.com -pv 1.0 -b $DIR
    fi
done
