pipeline {
  agent any
  stages {
    stage('Lint') {
  steps {
    sh '''
      set -euxo pipefail
      cat > "$WORKSPACE/in_lint.sh" <<'EOT'
set -eux

# 让所有缓存都写在 workspace 里，不要去 /.cache（没权限）
export GOLANGCI_LINT_CACHE="$PWD/.cache/golangci-lint"
export GOCACHE="$PWD/.cache/go-build"
export GOMODCACHE="$PWD/.cache/go-mod"

mkdir -p "$GOLANGCI_LINT_CACHE" "$GOCACHE" "$GOMODCACHE"

golangci-lint version
golangci-lint run --timeout=5m
EOT

        docker run --rm \
          --volumes-from jenkins \
          -w "$WORKSPACE" \
          -u 1000:1000 \
          golangci/golangci-lint:v1.59.1 \
          bash "$WORKSPACE/in_lint.sh"
      '''
    }
  }
    stage('CI') {
      steps {
        sh '''
          set -euxo pipefail
          cat > "$WORKSPACE/in_container.sh" <<'EOT'
          set -eux
          export GOCACHE="$PWD/.cache/go-build"
          export GOMODCACHE="$PWD/.cache/go-mod"
          mkdir -p "$GOCACHE" "$GOMODCACHE"
          chmod +x ./debug.sh ./ci.sh
          ./debug.sh
          ./ci.sh
EOT
          docker run --rm \
            --volumes-from jenkins \
            -w "$WORKSPACE" \
            -u 1000:1000 \
            golang:1.22 \
            bash "$WORKSPACE/in_container.sh"
        '''
      }
    }
stage('Build Image') {
  steps {
    sh '''
      set -euxo pipefail

      IMAGE="demo-ci-go"
      TAG="$(git rev-parse --short HEAD)"

      echo "Build: ${IMAGE}:${TAG}"
      docker version

      docker build -t "${IMAGE}:${TAG}" -t "${IMAGE}:latest" .

      docker images | grep "${IMAGE}" | head -n 20 || true
    '''
  }
}
