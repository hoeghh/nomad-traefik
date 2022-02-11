#!/bin/bash

# Fail on error exit codes
set -e
service=$(shuttle --skip-pull get service)


# Cleanup
rm -rf $tmp/$service
mkdir -p $tmp/$service

for f in templates/*.tmpl; do
  filename=$(basename -- "$f")
  echo "Processing $filename stanza";
  shuttle --skip-pull template $f -o $service/${service}.hcl 
done

for f in templates/*.toml; do
  filename=$(basename -- "$f")
  echo "Processing $filename config";
  shuttle --skip-pull template $f -o $service/${service}.toml 
done

