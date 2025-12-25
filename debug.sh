#!/usr/bin/env bash
set -u

echo "===== DEBUG START ====="

echo
echo "[WHO AM I]"
id || true

echo
echo "[PWD]"
pwd

echo
echo "[FILES]"
ls -la

echo
echo "[GIT]"
git rev-parse --is-inside-work-tree || true
git status -sb || true

echo
echo "[GO]"
which go || true
go version || true
echo "GOCACHE=${GOCACHE:-<unset>}"
echo "GOMODCACHE=${GOMODCACHE:-<unset>}"

echo
echo "[DOCKER]"
which docker || true
docker --version || true

echo
echo "[ENV]"
env | grep -E '^(PATH|HOME|USER|SHELL)=' || true

echo
echo "===== DEBUG END ====="
