#!/bin/bash

# Build packages
for i in $(ls -d src/*/); do
  # Pull dependencies only if requirements.yaml is present
  if [ -f "${i%%/}/requirements.yaml" ]; then
    rm -f ${i%%/}/requirements.lock 2>&1 >&/dev/null
    rm -rf ${i%%/}/charts/ 2>&1 >&/dev/null

    helm dep build \
      ${i%%/}
  fi

  # Build the chart
  helm package \
    -d dist \
    ${i%%/}
done

# Update repo index
helm repo index dist \
  --url https://ukube.github.io/charts/dist
