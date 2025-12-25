#!/usr/bin/env bash
set -euo pipefail

echo "[0/5] gofmt"
gofmt -w .
git diff --exit-code

echo "[1/5] tidy"
go mod tidy
git diff --exit-code

echo "[2/5] build"
go build ./...

echo "[3/5] test"
go test ./...

echo "[4/5] vet"
go vet ./...

echo "CI OK "
