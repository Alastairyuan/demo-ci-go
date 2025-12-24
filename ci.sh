#!/usr/bin/env bash
set -euo pipefail

echo "[1/4] tidy"
go mod tidy
git diff --exit-code

echo "[2/4] build"
go build ./...

echo "[3/4] test"
go test ./...

echo "[4/4] vet"
go vet ./...

echo "CI OK ✅"
