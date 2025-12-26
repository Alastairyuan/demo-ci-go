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
      chmod +x ./ci.sh

      docker run --rm \
        --volumes-from jenkins \
        -w "$WORKSPACE" \
        -u 1000:1000 \
        -e GOCACHE="$WORKSPACE/.cache/go-build" \
        -e GOMODCACHE="$WORKSPACE/.cache/go-mod" \
        golang:1.22 \
        bash -c 'export PATH=/usr/local/go/bin:$PATH; ./ci.sh'
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
    withCredentials([string(credentialsId: 'ghcr-token', variable: 'GH_TOKEN')]) {
      sh '''
        set -euxo pipefail

        echo "== DNS =="
        getent hosts ghcr.io || true

        echo "== HTTPS ping =="
        curl -v --max-time 10 https://ghcr.io/v2/ || true

        TAG="$(git rev-parse --short HEAD)"
        REPO="ghcr.io/alastairyuan/demo-ci-go"

        echo "$GH_TOKEN" | docker login ghcr.io -u alastairyuan --password-stdin

        docker tag demo-ci-go:latest "$REPO:$TAG"
        docker tag demo-ci-go:latest "$REPO:latest"

        # 简单粗暴：push 失败就重试几次（网络抖动很吃这一套）
        for i in 1 2 3; do
          docker push "$REPO:$TAG" && break
          echo "push failed, retry $i ..."
          sleep 5
        done

        docker push "$REPO:latest"
      '''
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
