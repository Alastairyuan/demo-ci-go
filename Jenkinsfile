pipeline {
  agent any

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  environment {
    // 项目名（镜像名）
    APP_NAME = 'demo-ci-go'

    // 你的 GHCR 命名空间（必须小写）
    GHCR_USER = 'alastairyuan'

    // 完整镜像仓库地址（必须小写）
    GHCR_IMAGE = "ghcr.io/${GHCR_USER}/${APP_NAME}"

    // 缓存目录（在 Jenkins workspace 里）
    CACHE_DIR = "${WORKSPACE}/.cache"
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
          mkdir -p "${CACHE_DIR}/golangci-lint" "${CACHE_DIR}/go-build" "${CACHE_DIR}/go-mod"

          docker run --rm --volumes-from jenkins \
            -w "${WORKSPACE}" \
            -u 1000:1000 \
            -e GOLANGCI_LINT_CACHE="${CACHE_DIR}/golangci-lint" \
            -e GOCACHE="${CACHE_DIR}/go-build" \
            -e GOMODCACHE="${CACHE_DIR}/go-mod" \
            golangci/golangci-lint:v1.59.1 \
            golangci-lint run --timeout=5m
        '''
      }
    }

    stage('CI') {
      steps {
        sh '''
          set -euxo pipefail
          mkdir -p "${CACHE_DIR}/go-build" "${CACHE_DIR}/go-mod"
          chmod +x ./ci.sh

          # 用 golang 官方镜像跑 ci.sh
          # 注意：bash -lc + export PATH，避免你之前 gofmt 找不到
          docker run --rm --volumes-from jenkins \
            -w "${WORKSPACE}" \
            -u 1000:1000 \
            -e GOCACHE="${CACHE_DIR}/go-build" \
            -e GOMODCACHE="${CACHE_DIR}/go-mod" \
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
          echo "TAG=${TAG}" > .build.env

          docker build -t "${APP_NAME}:${TAG}" -t "${APP_NAME}:latest" .

          echo "== local images =="
          docker images | head -n 30
        '''
      }
    }

    stage('Push Image to GHCR') {
      when {
        // main 分支才 push（你也可以改成 always()）
        branch 'main'
      }
      steps {
        withCredentials([
          usernamePassword(credentialsId: 'gh-token', usernameVariable: 'GH_USER', passwordVariable: 'GH_TOKEN')
        ]) {
          sh '''
            set -euxo pipefail
            . ./.build.env
            echo "Will push: ${GHCR_IMAGE}:${TAG} and ${GHCR_IMAGE}:latest"

            echo "== Preflight: DNS =="
            getent hosts ghcr.io || true
            echo "== Preflight: HTTPS =="
            curl -sS -I --max-time 10 https://ghcr.io/v2/ || true

            echo "${GH_TOKEN}" | docker login ghcr.io -u "${GH_USER}" --password-stdin

            docker tag "${APP_NAME}:latest" "${GHCR_IMAGE}:${TAG}"
            docker tag "${APP_NAME}:latest" "${GHCR_IMAGE}:latest"

            # 推送容易 EOF，做重试
            tries=0
            until [ "$tries" -ge 4 ]; do
              tries=$((tries+1))
              echo "== Push try ${tries}/4: ${GHCR_IMAGE}:${TAG} =="
              if docker push "${GHCR_IMAGE}:${TAG}"; then
                break
              fi
              echo "push failed, retry..."
              sleep $((tries*5))
            done

            # latest 也推一下
            tries=0
            until [ "$tries" -ge 4 ]; do
              tries=$((tries+1))
              echo "== Push try ${tries}/4: ${GHCR_IMAGE}:latest =="
              if docker push "${GHCR_IMAGE}:latest"; then
                break
              fi
              echo "push failed, retry..."
              sleep $((tries*5))
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
        docker logout ghcr.io >/dev/null 2>&1 || true
      '''
    }
  }
}
