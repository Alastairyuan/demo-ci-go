pipeline {
  agent any

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  environment {
    APP_NAME = "demo-ci-go"
    GHCR_REGISTRY = "ghcr.io"
    GHCR_OWNER = "alastairyuan"          // 注意：GHCR 必须小写
    GHCR_REPO  = "demo-ci-go"            // 你的镜像仓库名
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh '''
          set -euxo pipefail
          echo "== repo =="
          git remote -v
          echo "== commit =="
          git rev-parse --short HEAD
        '''
      }
    }

    stage('Lint') {
      steps {
        sh '''
          set -euxo pipefail
          mkdir -p .cache/golangci-lint .cache/go-build .cache/go-mod
          docker run --rm --volumes-from jenkins \
            -w "$PWD" -u 1000:1000 \
            -e GOLANGCI_LINT_CACHE="$PWD/.cache/golangci-lint" \
            -e GOCACHE="$PWD/.cache/go-build" \
            -e GOMODCACHE="$PWD/.cache/go-mod" \
            golangci/golangci-lint:v1.59.1 \
            golangci-lint run --timeout=5m
        '''
      }
    }

    stage('CI') {
      steps {
        sh '''
          set -euxo pipefail
          mkdir -p .cache/go-build .cache/go-mod
          chmod +x ./ci.sh
          docker run --rm --volumes-from jenkins \
            -w "$PWD" -u 1000:1000 \
            -e GOCACHE="$PWD/.cache/go-build" \
            -e GOMODCACHE="$PWD/.cache/go-mod" \
            golang:1.22 \
            bash -lc 'export PATH=/usr/local/go/bin:$PATH; ./ci.sh'
        '''
      }
    }

    stage('Build Image') {
      steps {
        sh '''
          set -euxo pipefail
          TAG=$(git rev-parse --short HEAD)
          echo "TAG=$TAG"
          docker build -t ${APP_NAME}:${TAG} -t ${APP_NAME}:latest .
          echo "== local images =="
          docker images | head -n 30
        '''
      }
    }

    stage('Push Image to GHCR') {
      steps {
        withCredentials([string(credentialsId: 'gh-token', variable: 'GH_TOKEN')]) {
          sh '''
            set -euxo pipefail
            TAG=$(git rev-parse --short HEAD)
            IMAGE="${GHCR_REGISTRY}/${GHCR_OWNER}/${GHCR_REPO}"

            echo "$GH_TOKEN" | docker login ${GHCR_REGISTRY} -u ${GHCR_OWNER} --password-stdin

            docker tag ${APP_NAME}:latest ${IMAGE}:${TAG}
            docker tag ${APP_NAME}:latest ${IMAGE}:latest

            # 推送可能偶发 EOF，所以做个小重试
            for i in 1 2 3; do
              docker push ${IMAGE}:${TAG} && break || (echo "push tag failed, retry $i..." && sleep 5)
            done
            for i in 1 2 3; do
              docker push ${IMAGE}:latest && break || (echo "push latest failed, retry $i..." && sleep 5)
            done
          '''
        }
      }
    }
  }

  post {
    always {
      sh '''
        set +e
        docker logout ghcr.io
      '''
    }
  }
}
