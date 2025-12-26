pipeline {
  agent any

  environment {
    APP_IMAGE = "demo-ci-go"
    GHCR_REPO = "ghcr.io/alastairyuan/demo-ci-go"
    // 让 cache 落在 workspace，避免容器里每次全重来
    GOLANGCI_LINT_CACHE = "${WORKSPACE}/.cache/golangci-lint"
    GOCACHE            = "${WORKSPACE}/.cache/go-build"
    GOMODCACHE         = "${WORKSPACE}/.cache/go-mod"
  }

  options {
    timestamps()
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
          mkdir -p "$GOLANGCI_LINT_CACHE" "$GOCACHE" "$GOMODCACHE"
          docker run --rm --volumes-from jenkins \
            -w "$WORKSPACE" -u 1000:1000 \
            -e GOLANGCI_LINT_CACHE="$GOLANGCI_LINT_CACHE" \
            -e GOCACHE="$GOCACHE" \
            -e GOMODCACHE="$GOMODCACHE" \
            golangci/golangci-lint:v1.59.1 \
            golangci-lint run --timeout=5m
        '''
      }
    }

    stage('CI') {
      steps {
        sh '''
          set -euxo pipefail
          mkdir -p "$GOCACHE" "$GOMODCACHE"
          chmod +x ./ci.sh
          docker run --rm --volumes-from jenkins \
            -w "$WORKSPACE" -u 1000:1000 \
            -e GOCACHE="$GOCACHE" \
            -e GOMODCACHE="$GOMODCACHE" \
            golang:1.22 \
            bash -lc 'export PATH=/usr/local/go/bin:$PATH; ./ci.sh'
        '''
      }
    }

    stage('Build Image') {
      steps {
        sh '''
          set -euxo pipefail
          TAG="$(git rev-parse --short HEAD)"
          docker build -t "$APP_IMAGE:$TAG" -t "$APP_IMAGE:latest" .
          docker images | head -n 30
        '''
      }
    }

    stage('Push Image to GHCR') {
      steps {
        withCredentials([string(credentialsId: 'ghcr-token', variable: 'GH_TOKEN')]) {
          sh '''
            set -euxo pipefail

            echo "== DNS =="
            getent hosts ghcr.io || true

            echo "== HTTPS ping =="
            curl -v --max-time 10 https://ghcr.io/v2/ || true

            TAG="$(git rev-parse --short HEAD)"

            echo "$GH_TOKEN" | docker login ghcr.io -u alastairyuan --password-stdin

            docker tag "$APP_IMAGE:latest" "$GHCR_REPO:$TAG"
            docker tag "$APP_IMAGE:latest" "$GHCR_REPO:latest"

            for i in 1 2 3; do
              docker push "$GHCR_REPO:$TAG" && break
              echo "push failed, retry $i ..."
              sleep 5
            done

            docker push "$GHCR_REPO:latest"
          '''
        }
      }
    }

  } // stages

  post {
    always {
      sh '''
        set +e
        docker logout ghcr.io >/dev/null 2>&1 || true
      '''
    }
  }
}
