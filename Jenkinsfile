pipeline {
  agent any

  environment {
    IMAGE_LOCAL = "demo-ci-go"
    GHCR_IMAGE  = "ghcr.io/alastairyuan/demo-ci-go"   // 必须全小写
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Lint') {
      steps {
        sh '''
          set -euxo pipefail

          mkdir -p "$WORKSPACE/.cache/golangci-lint" "$WORKSPACE/.cache/go-build" "$WORKSPACE/.cache/go-mod"

          docker run --rm \
            --volumes-from jenkins \
            -w "$WORKSPACE" \
            -u 1000:1000 \
            -e GOLANGCI_LINT_CACHE="$WORKSPACE/.cache/golangci-lint" \
            -e GOCACHE="$WORKSPACE/.cache/go-build" \
            -e GOMODCACHE="$WORKSPACE/.cache/go-mod" \
            golangci/golangci-lint:v1.59.1 \
            golangci-lint run --timeout=5m
        '''
      }
    }

    stage('CI') {
      steps {
        sh '''
          set -euxo pipefail

          mkdir -p "$WORKSPACE/.cache/go-build" "$WORKSPACE/.cache/go-mod"

          docker run --rm \
            --volumes-from jenkins \
            -w "$WORKSPACE" \
            -u 1000:1000 \
            -e GOCACHE="$WORKSPACE/.cache/go-build" \
            -e GOMODCACHE="$WORKSPACE/.cache/go-mod" \
            golang:1.22 \
            bash -lc './ci.sh'
        '''
      }
    }

    stage('Build Image') {
      steps {
        sh '''
          set -euxo pipefail

          TAG="$(git rev-parse --short HEAD)"

          docker version
          docker build -t "${IMAGE_LOCAL}:${TAG}" -t "${IMAGE_LOCAL}:latest" .

          docker images | head -n 30 | grep -E "(${IMAGE_LOCAL})" || true
        '''
      }
    }

    stage('Push Image to GHCR') {
      steps {
        withCredentials([string(credentialsId: 'gh-token', variable: 'GH_TOKEN')]) {
          sh '''
            set -euxo pipefail

            TAG="$(git rev-parse --short HEAD)"

            echo "$GH_TOKEN" | docker login ghcr.io -u alastairyuan --password-stdin

            docker tag "${IMAGE_LOCAL}:latest" "${GHCR_IMAGE}:${TAG}"
            docker tag "${IMAGE_LOCAL}:latest" "${GHCR_IMAGE}:latest"

            docker push "${GHCR_IMAGE}:${TAG}"
            docker push "${GHCR_IMAGE}:latest"
          '''
        }
      }
    }
  }

  post {
    always {
      sh '''
        set +e
        docker logout ghcr.io >/dev/null 2>&1 || true
      '''
    }
  }
}
