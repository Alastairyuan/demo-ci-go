pipeline {
  agent any

  environment {
    // 你的 GH 用户名（建议全小写）
    GH_USER = 'alastairyuan'
    // 镜像名（仓库名，建议小写）
    IMAGE_NAME = 'demo-ci-go'

    // Go / Lint 镜像
    GO_IMAGE   = 'golang:1.22'
    LINT_IMAGE = 'golangci/golangci-lint:v1.59.1'
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
          mkdir -p .cache/golangci-lint .cache/go-build .cache/go-mod

          docker run --rm --volumes-from jenkins \
            -w "$WORKSPACE" -u 1000:1000 \
            -e GOLANGCI_LINT_CACHE="$WORKSPACE/.cache/golangci-lint" \
            -e GOCACHE="$WORKSPACE/.cache/go-build" \
            -e GOMODCACHE="$WORKSPACE/.cache/go-mod" \
            ${LINT_IMAGE} golangci-lint run --timeout=5m
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
            -w "$WORKSPACE" -u 1000:1000 \
            -e GOCACHE="$WORKSPACE/.cache/go-build" \
            -e GOMODCACHE="$WORKSPACE/.cache/go-mod" \
            ${GO_IMAGE} bash -lc 'export PATH=/usr/local/go/bin:$PATH; ./ci.sh'
        '''
      }
    }

    stage('Build Image') {
      steps {
        sh '''
          set -euxo pipefail
          TAG="$(git rev-parse --short HEAD)"
          docker build -t ${IMAGE_NAME}:${TAG} -t ${IMAGE_NAME}:latest .
          docker images | head -n 30
        '''
      }
    }

    stage('Push Image to GHCR') {
      when {
        branch 'main'
      }
      steps {
        withCredentials([string(credentialsId: 'gh-token', variable: 'GH_TOKEN')]) {
          sh '''
            set -euxo pipefail

            # 诊断：看看 ghcr 是否能解析/连通
            echo "== DNS =="
            getent hosts ghcr.io || true
            echo "== HTTPS ping =="
            curl -v --max-time 10 https://ghcr.io/v2/ || true

            TAG="$(git rev-parse --short HEAD)"

            # 镜像名必须小写
            REPO="ghcr.io/${GH_USER}/${IMAGE_NAME}"
            REPO="$(echo "$REPO" | tr '[:upper:]' '[:lower:]')"

            echo "$GH_TOKEN" | docker login ghcr.io -u "${GH_USER}" --password-stdin

            docker tag ${IMAGE_NAME}:latest ${REPO}:${TAG}
            docker tag ${IMAGE_NAME}:latest ${REPO}:latest

            # push 带重试（网络偶发 EOF 很常见）
            retry_push () {
              local img="$1"
              local n=1
              local max=5
              while true; do
                if docker push "$img"; then
                  break
                fi
                if [ "$n" -ge "$max" ]; then
                  echo "push failed after $n tries: $img"
                  exit 1
                fi
                echo "push failed, retry $n/$max ... (sleep 5s)"
                n=$((n+1))
                sleep 5
              done
            }

            retry_push ${REPO}:${TAG}
            retry_push ${REPO}:latest
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
