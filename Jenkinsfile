pipeline {
  agent any
  stages {
    stage('CI') {
      steps {
        sh '''
          set -euxo pipefail
          cat > "$WORKSPACE/in_container.sh" <<'EOT'
          set -eux
          export GOCACHE="$PWD/.cache/go-build"
          export GOMODCACHE="$PWD/.cache/go-mod"
          mkdir -p "$GOCACHE" "$GOMODCACHE"
          chmod +x ./ci.sh
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
  }
}
