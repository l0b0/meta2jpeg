#!/usr/bin/env bash

set -o errexit -o noclobber -o nounset -o pipefail

shopt -s extglob nullglob

for raw
do
    jpegs=( "${raw%.*}"*.jp{,e}g )
    if [ ${#jpegs[@]} -eq 0 ]
    then
        # No JPEG found
        continue
    fi
    for jpeg in "${jpegs[@]}"
    do
        exiv2 -v extract "$raw"

        name="${raw%.*}"
        exiv="${jpeg%.*}.exv"
        mv "${raw%.*}.exv" "$exiv"

        exiv2 -v insert "$jpeg"
        rm -- "$exiv"
    done
done
