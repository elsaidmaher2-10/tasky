#!/usr/bin/env sh
# Build the demo and serve the static result on http://localhost:8080
set -e
cd "$(dirname "$0")"
npm install
npm run build
cd dist && python3 -m http.server 8080
