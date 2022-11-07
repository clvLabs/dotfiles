#!/bin/bash
SRC=${1}
DST=${2}

if [[ -z "${SRC}" ]] || [[ -z "${DST}" ]]; then
  echo "Usage: $(basename ${0}) source-md-file dest-pdf-file"
  exit 1
fi

pandoc \
  --variable "geometry=margin=2cm" \
  ${SRC} \
  --pdf-engine=xelatex \
  -o ${DST}
