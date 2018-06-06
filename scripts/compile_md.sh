#!/bin/bash

# Compiles markdown in source directory to html with same directory structure (see .circleci/config.yml)
# Usage ./compile_md.sh -s SOURCE_DIR -t TARGET_DIR

while getopts s:t: option
do
 case "${option}"
 in
 s) SOURCE_DIR=${OPTARG};;
 t) TARGET_DIR=${OPTARG};;
 esac
done

cd $SOURCE_DIR

for f in $(find . -name '*.md'); do
  basedir=$(dirname "${f}")
  outDir="../${TARGET_DIR}/${basedir//\.\//}"
  mkdir -p "${outDir}"
  filename=$(basename "${f}")
  pandoc -s --from markdown --to html "$f" > ${outDir}/${filename%.md}.html
done

for f in $(find . -name '*.css'); do
  basedir=$(dirname "${f}")
  outDir="../${TARGET_DIR}/${basedir//\.\//}"
  mkdir -p "${outDir}"
  filename=$(basename "${f}")
  cat ${f} > ${outDir}/${filename}
done
