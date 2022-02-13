#!/bin/sh

# Fail on error exit codes
set -e
service=$(shuttle --skip-pull get service)

if [ -z "$tmp" ]; then
  echo "You need to run this through shuttle"
  echo "Exiting..."
  exit 1
fi

# Cleanup
rm -rf $tmp/$service
mkdir -p $tmp/$service

# Template 
if [ ! $(stat -t -- *.tmpl >/dev/null 2>&1) ]; then
  for f in templates/*.tmpl; do
    if [ ! -z "$f" ]; then
      filename=$(basename -- "$f")
      echo "Processing $filename stanza";
      shuttle --skip-pull template $f -o $service/${service}.hcl 
    fi
  done
fi
