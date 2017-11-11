#!/bin/bash

# Build packages
for i in $(ls -d src/*/); do
  helm package \
    -d dist \
    ${i%%/}
done

# Update repo index
helm repo index dist \
  --url https://ukube.github.io/charts/dist
