pipeline {
  agent any

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  environment {
    APP_NAME      = "demo-ci-go"
    GHCR_REGISTRY = "ghcr.io"
    GHCR_OWNER    = "alastairyuan"   // 必须小写
    GHCR_REPO     = "demo-ci-go"
    CONTAINER     = "demo-ci-go"
    APP_PORT      = "8080"
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

          docker build \
            -t ${APP_NAME}:${TAG} \
            -t ${APP_NAME}:latest \
            .

          docker images | head -n 20
        '''
      }
    }

    stage('Push Image to GHCR') {
      when { branch 'main' }
      steps {
        withCredentials([string(credentialsId: 'gh-token', variable: 'GH_TOKEN')]) {
          sh '''
            set -euxo pipefail

            TAG=$(git rev-parse --short HEAD)
            IMAGE="${GHCR_REGISTRY}/${GHCR_OWNER}/${GHCR_REPO}"

            echo "$GH_TOKEN" | docker login ${GHCR_REGISTRY} \
              -u ${GHCR_OWNER} --password-stdin

            docker tag ${APP_NAME}:latest ${IMAGE}:${TAG}
            docker tag ${APP_NAME}:latest ${IMAGE}:latest

            docker push ${IMAGE}:${TAG}
            docker push ${IMAGE}:latest
          '''
        }
      }
    }

    stage('Deploy (Local CD)') {
      when { branch 'main' }
      steps {
        withCredentials([string(credentialsId: 'gh-token', variable: 'GH_TOKEN')]) {
          sh '''
            set -euxo pipefail

            IMAGE="${GHCR_REGISTRY}/${GHCR_OWNER}/${GHCR_REPO}:latest"

            echo "$GH_TOKEN" | docker login ${GHCR_REGISTRY} \
              -u ${GHCR_OWNER} --password-stdin

            docker pull "$IMAGE"

            # 停掉并删除旧容器（如果存在）
            docker rm -f ${CONTAINER} || true

            # 启动新容器（8080 -> 8080）
            docker run -d \
              --name ${CONTAINER} \
              --restart=always \
              -p ${APP_PORT}:${APP_PORT} \
              "$IMAGE"

            docker ps --filter "name=${CONTAINER}"
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
