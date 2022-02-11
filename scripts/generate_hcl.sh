#!/bin/bash

# Fail on error exit codes
set -e
service=$(shuttle --skip-pull get service)


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

# Ensure clean slate
if [ ! -d "./gitops/$service" ]; then
  rm -rf ./gitops/$service/*
  mkdir -p ./gitops/$service
fi

# Move stanzas to gitops folder
mv $tmp/$service/* ./gitops/$service/