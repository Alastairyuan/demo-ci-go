Started by an SCM change
Obtained Jenkinsfile from git git@github.com:Alastairyuan/demo-ci-go.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/demo-ci-go-pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-ssh
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/demo-ci-go-pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url git@github.com:Alastairyuan/demo-ci-go.git # timeout=10
Fetching upstream changes from git@github.com:Alastairyuan/demo-ci-go.git
 > git --version # timeout=10
 > git --version # 'git version 2.47.3'
using GIT_SSH to set credentials ssh key
Verifying host key using known hosts file
 > git fetch --tags --force --progress -- git@github.com:Alastairyuan/demo-ci-go.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision b59881b14c6c79676af491d8eed6bce841ae3783 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f b59881b14c6c79676af491d8eed6bce841ae3783 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk 70a45e1077f3dc87c3847250c4b126a33f787df2 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] timestamps
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] checkout
20:07:37  Selected Git installation does not exist. Using Default
20:07:37  The recommended git tool is: NONE
20:07:37  using credential github-ssh
20:07:37   > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/demo-ci-go-pipeline/.git # timeout=10
20:07:37  Fetching changes from the remote Git repository
20:07:37   > git config remote.origin.url git@github.com:Alastairyuan/demo-ci-go.git # timeout=10
20:07:37  Fetching upstream changes from git@github.com:Alastairyuan/demo-ci-go.git
20:07:37   > git --version # timeout=10
20:07:37   > git --version # 'git version 2.47.3'
20:07:37  using GIT_SSH to set credentials ssh key
20:07:37  Verifying host key using known hosts file
20:07:37   > git fetch --tags --force --progress -- git@github.com:Alastairyuan/demo-ci-go.git +refs/heads/*:refs/remotes/origin/* # timeout=10
20:07:44   > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
20:07:44  Checking out Revision b59881b14c6c79676af491d8eed6bce841ae3783 (refs/remotes/origin/main)
20:07:44   > git config core.sparsecheckout # timeout=10
20:07:44   > git checkout -f b59881b14c6c79676af491d8eed6bce841ae3783 # timeout=10
20:07:44  Commit message: "Update Jenkinsfile"
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Lint)
[Pipeline] sh
20:07:45  + set -euxo pipefail
20:07:45  + mkdir -p /var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/golangci-lint /var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-build /var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-mod
20:07:45  + docker run --rm --volumes-from jenkins -w /var/jenkins_home/workspace/demo-ci-go-pipeline -u 1000:1000 -e GOLANGCI_LINT_CACHE=/var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/golangci-lint -e GOCACHE=/var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-build -e GOMODCACHE=/var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-mod golangci/golangci-lint:v1.59.1 golangci-lint run --timeout=5m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (CI)
[Pipeline] sh
20:07:51  + set -euxo pipefail
20:07:51  + mkdir -p /var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-build /var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-mod
20:07:51  + chmod +x ./ci.sh
20:07:51  + docker run --rm --volumes-from jenkins -w /var/jenkins_home/workspace/demo-ci-go-pipeline -u 1000:1000 -e GOCACHE=/var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-build -e GOMODCACHE=/var/jenkins_home/workspace/demo-ci-go-pipeline/.cache/go-mod golang:1.22 bash -lc export PATH=/usr/local/go/bin:$PATH; ./ci.sh
20:07:53  [0/5] gofmt
20:07:53  [1/5] tidy
20:07:53  [2/5] build
20:07:53  [3/5] test
20:07:54  ok  	github.com/yuanqianhao2005/demo-ci-go	(cached)
20:07:54  [4/5] vet
20:07:55  CI OK 
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Image)
[Pipeline] sh
20:07:57  + set -euxo pipefail
20:07:57  + git rev-parse --short HEAD
20:07:57  + TAG=b59881b
20:07:57  + docker build -t demo-ci-go:b59881b -t demo-ci-go:latest .
20:07:59  #0 building with "default" instance using docker driver
20:07:59  
20:07:59  #1 [internal] load build definition from Dockerfile
20:07:59  #1 transferring dockerfile: 387B 0.0s done
20:07:59  #1 DONE 0.0s
20:07:59  
20:07:59  #2 [internal] load metadata for gcr.io/distroless/static:nonroot
20:07:59  #2 DONE 0.0s
20:07:59  
20:07:59  #3 [internal] load metadata for docker.io/library/golang:1.22
20:07:59  #3 DONE 0.0s
20:07:59  
20:07:59  #4 [internal] load .dockerignore
20:07:59  #4 transferring context: 2B 0.0s done
20:07:59  #4 DONE 0.0s
20:07:59  
20:07:59  #5 [builder 1/6] FROM docker.io/library/golang:1.22
20:07:59  #5 DONE 0.0s
20:07:59  
20:07:59  #6 [stage-1 1/3] FROM gcr.io/distroless/static:nonroot
20:07:59  #6 DONE 0.0s
20:07:59  
20:07:59  #7 [internal] load build context
20:08:01  #7 transferring context: 274.43kB 1.8s done
20:08:01  #7 DONE 1.9s
20:08:01  
20:08:01  #8 [builder 2/6] WORKDIR /src
20:08:01  #8 CACHED
20:08:01  
20:08:01  #9 [builder 3/6] COPY go.mod ./
20:08:01  #9 CACHED
20:08:01  
20:08:01  #10 [builder 4/6] RUN go mod download
20:08:01  #10 CACHED
20:08:01  
20:08:01  #11 [builder 5/6] COPY . .
20:08:06  #11 DONE 4.4s
20:08:06  
20:08:06  #12 [builder 6/6] RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/app .
20:08:08  #12 DONE 1.9s
20:08:08  
20:08:08  #13 [stage-1 2/3] COPY --from=builder /out/app /app
20:08:08  #13 CACHED
20:08:08  
20:08:08  #14 exporting to image
20:08:08  #14 exporting layers done
20:08:08  #14 writing image sha256:b3e0dde6e3b04efe023017a52e15be29a819a15583807d036d979043e01e12e0 0.1s done
20:08:08  #14 naming to docker.io/library/demo-ci-go:b59881b 0.1s done
20:08:08  #14 naming to docker.io/library/demo-ci-go:latest
20:08:08  #14 naming to docker.io/library/demo-ci-go:latest 0.0s done
20:08:08  #14 DONE 0.2s
20:08:08  + head -n 30+ 
20:08:08  docker images
20:08:08  REPOSITORY                        TAG       IMAGE ID       CREATED             SIZE
20:08:08  demo-ci-go                        70a45e1   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        76396c4   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        9595524   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        95d704a   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        b59881b   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        d2c5fdd   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        latest    b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  ghcr.io/alastairyuan/demo-ci-go   95d704a   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  ghcr.io/alastairyuan/demo-ci-go   d2c5fdd   b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  ghcr.io/alastairyuan/demo-ci-go   latest    b3e0dde6e3b0   About an hour ago   2.08MB
20:08:08  demo-ci-go                        test      fd2a56bb9264   3 hours ago         2.08MB
20:08:08  <none>                            <none>    e54aa3369633   3 hours ago         823MB
20:08:08  <none>                            <none>    ad255272694c   25 hours ago        499MB
20:08:08  jenkins/jenkins                   lts       75109de20007   2 weeks ago         499MB
20:08:08  golang                            1.22      2fce09cfad57   10 months ago       823MB
20:08:08  golangci/golangci-lint            v1.59.1   84c26514caa5   18 months ago       851MB
20:08:08  gcr.io/distroless/static          nonroot   caf5a62f4ea6   N/A                 2.08MB
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push Image to GHCR)
[Pipeline] withCredentials
20:08:09  Masking supported pattern matches of $GH_TOKEN
[Pipeline] {
[Pipeline] sh
20:08:09  + set -euxo pipefail
20:08:09  + echo == DNS ==
20:08:09  == DNS ==
20:08:09  + getent hosts ghcr.io
20:08:11  20.205.243.164  ghcr.io
20:08:11  + echo == HTTPS ping ==
20:08:11  == HTTPS ping ==
20:08:11  + curl -v --max-time 10 https://ghcr.io/v2/
20:08:12    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
20:08:12                                   Dload  Upload   Total   Spent    Left  Speed
20:08:12  
20:08:12    0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
20:08:12    0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* Host ghcr.io:443 was resolved.
20:08:12  * IPv6: (none)
20:08:12  * IPv4: 20.205.243.164
20:08:12  *   Trying 20.205.243.164:443...
20:08:13  * ALPN: curl offers h2,http/1.1
20:08:13  } [5 bytes data]
20:08:13  * TLSv1.3 (OUT), TLS handshake, Client hello (1):
20:08:13  } [1562 bytes data]
20:08:13  *  CAfile: /etc/ssl/certs/ca-certificates.crt
20:08:13  *  CApath: /etc/ssl/certs
20:08:13  { [5 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, Server hello (2):
20:08:13  { [122 bytes data]
20:08:13  * TLSv1.3 (IN), TLS change cipher, Change cipher spec (1):
20:08:13  { [1 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
20:08:13  { [19 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, Certificate (11):
20:08:13  { [4827 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, CERT verify (15):
20:08:13  { [520 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, Finished (20):
20:08:13  { [36 bytes data]
20:08:13  * TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
20:08:13  } [1 bytes data]
20:08:13  * TLSv1.3 (OUT), TLS handshake, Finished (20):
20:08:13  } [36 bytes data]
20:08:13  * SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256 / x25519 / RSASSA-PSS
20:08:13  * ALPN: server accepted h2
20:08:13  * Server certificate:
20:08:13  *  subject: CN=*.ghcr.io
20:08:13  *  start date: May 14 00:00:00 2025 GMT
20:08:13  *  expire date: May 14 23:59:59 2026 GMT
20:08:13  *  subjectAltName: host "ghcr.io" matched cert's "ghcr.io"
20:08:13  *  issuer: C=GB; ST=Greater Manchester; L=Salford; O=Sectigo Limited; CN=Sectigo RSA Domain Validation Secure Server CA
20:08:13  *  SSL certificate verify ok.
20:08:13  *   Certificate level 0: Public key type RSA (4096/152 Bits/secBits), signed using sha256WithRSAEncryption
20:08:13  *   Certificate level 1: Public key type RSA (2048/112 Bits/secBits), signed using sha384WithRSAEncryption
20:08:13  *   Certificate level 2: Public key type RSA (4096/152 Bits/secBits), signed using sha384WithRSAEncryption
20:08:13  * Connected to ghcr.io (20.205.243.164) port 443
20:08:13  * using HTTP/2
20:08:13  * [HTTP/2] [1] OPENED stream for https://ghcr.io/v2/
20:08:13  * [HTTP/2] [1] [:method: GET]
20:08:13  * [HTTP/2] [1] [:scheme: https]
20:08:13  * [HTTP/2] [1] [:authority: ghcr.io]
20:08:13  * [HTTP/2] [1] [:path: /v2/]
20:08:13  * [HTTP/2] [1] [user-agent: curl/8.14.1]
20:08:13  * [HTTP/2] [1] [accept: */*]
20:08:13  } [5 bytes data]
20:08:13  > GET /v2/ HTTP/2
20:08:13  > Host: ghcr.io
20:08:13  > User-Agent: curl/8.14.1
20:08:13  > Accept: */*
20:08:13  > 
20:08:13  * Request completely sent off
20:08:13  { [5 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
20:08:13  { [57 bytes data]
20:08:13  * TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
20:08:13  { [57 bytes data]
20:08:13  < HTTP/2 401 
20:08:13  < content-type: application/json
20:08:13  < docker-distribution-api-version: registry/2.0
20:08:13  < strict-transport-security: max-age=63072000; includeSubDomains; preload
20:08:13  < www-authenticate: Bearer realm="https://ghcr.io/token",service="ghcr.io",scope="repository:user/image:pull"
20:08:13  < date: Fri, 26 Dec 2025 07:59:30 GMT
20:08:13  < content-length: 73
20:08:13  < x-github-request-id: D5D4:25D6A2:416760:A505C8:694E4061
20:08:13  < 
20:08:13  { [73 bytes data]
20:08:13  
20:08:13  100    73  100    73    0     0     39      0  0:00:01  0:00:01 --:--:--    39
20:08:13  100    73  100    73    0     0     39      0  0:00:01  0:00:01 --:--:--    39
20:08:13  * Connection #0 to host ghcr.io left intact
20:08:13  {"errors":[{"code":"UNAUTHORIZED","message":"authentication required"}]}
20:08:13  + git rev-parse --short HEAD
20:08:13  + TAG=b59881b
20:08:13  + echo ****
20:08:13  + docker login ghcr.io -u alastairyuan --password-stdin
20:08:20  WARNING! Your password will be stored unencrypted in /var/jenkins_home/.docker/config.json.
20:08:20  Configure a credential helper to remove this warning. See
20:08:20  https://docs.docker.com/engine/reference/commandline/login/#credentials-store
20:08:20  
20:08:20  Login Succeeded
20:08:20  + docker tag demo-ci-go:latest ghcr.io/alastairyuan/demo-ci-go:b59881b
20:08:20  + docker tag demo-ci-go:latest ghcr.io/alastairyuan/demo-ci-go:latest
20:08:20  + docker push ghcr.io/alastairyuan/demo-ci-go:b59881b
20:08:24  The push refers to repository [ghcr.io/alastairyuan/demo-ci-go]
20:08:25  a3640b9fa24b: Preparing
20:08:25  33b37ab0b090: Preparing
20:08:25  6e7fbcf090d0: Preparing
20:08:25  1a73b54f556b: Preparing
20:08:25  4cde6b0bb6f5: Preparing
20:08:25  bd3cdfae1d3f: Preparing
20:08:25  6f1cdceb6a31: Preparing
20:08:25  af5aa97ebe6c: Preparing
20:08:25  4d049f83d9cf: Preparing
20:08:25  114dde0fefeb: Preparing
20:08:25  4840c7c54023: Preparing
20:08:25  8fa10c0194df: Preparing
20:08:25  bd3cdfae1d3f: Waiting
20:08:25  6f1cdceb6a31: Waiting
20:08:25  af5aa97ebe6c: Waiting
20:08:25  4d049f83d9cf: Waiting
20:08:25  114dde0fefeb: Waiting
20:08:25  4840c7c54023: Waiting
20:08:25  bff7f7a9d443: Preparing
20:08:25  8fa10c0194df: Waiting
20:08:25  bff7f7a9d443: Waiting
20:08:29  1a73b54f556b: Layer already exists
20:08:29  33b37ab0b090: Layer already exists
20:08:29  4cde6b0bb6f5: Layer already exists
20:08:29  a3640b9fa24b: Layer already exists
20:08:29  6e7fbcf090d0: Layer already exists
20:08:29  af5aa97ebe6c: Layer already exists
20:08:39  4840c7c54023: Retrying in 5 seconds
20:08:39  4d049f83d9cf: Retrying in 5 seconds
20:08:39  6f1cdceb6a31: Retrying in 5 seconds
20:08:39  4840c7c54023: Retrying in 4 seconds
20:08:39  4d049f83d9cf: Retrying in 4 seconds
20:08:39  114dde0fefeb: Retrying in 5 seconds
20:08:39  6f1cdceb6a31: Retrying in 4 seconds
20:08:39  4840c7c54023: Retrying in 3 seconds
20:08:40  4d049f83d9cf: Retrying in 3 seconds
20:08:40  114dde0fefeb: Retrying in 4 seconds
20:08:40  6f1cdceb6a31: Retrying in 3 seconds
20:08:41  4840c7c54023: Retrying in 2 seconds
20:08:41  bd3cdfae1d3f: Pushed
20:08:41  4d049f83d9cf: Retrying in 2 seconds
20:08:41  114dde0fefeb: Retrying in 3 seconds
20:08:41  6f1cdceb6a31: Retrying in 2 seconds
20:08:41  4840c7c54023: Retrying in 1 second
20:08:42  8fa10c0194df: Layer already exists
20:08:42  4d049f83d9cf: Retrying in 1 second
20:08:42  114dde0fefeb: Retrying in 2 seconds
20:08:42  6f1cdceb6a31: Retrying in 1 second
20:08:43  114dde0fefeb: Retrying in 1 second
20:08:45  bff7f7a9d443: Layer already exists
20:08:48  4840c7c54023: Retrying in 10 seconds
20:08:48  114dde0fefeb: Retrying in 10 seconds
20:08:48  4d049f83d9cf: Retrying in 10 seconds
20:08:49  4840c7c54023: Retrying in 9 seconds
20:08:49  114dde0fefeb: Retrying in 9 seconds
20:08:49  4d049f83d9cf: Retrying in 9 seconds
20:08:50  4840c7c54023: Retrying in 8 seconds
20:08:50  114dde0fefeb: Retrying in 8 seconds
20:08:51  4d049f83d9cf: Retrying in 8 seconds
20:08:51  4840c7c54023: Retrying in 7 seconds
20:08:51  114dde0fefeb: Retrying in 7 seconds
20:08:51  4d049f83d9cf: Retrying in 7 seconds
20:08:52  4840c7c54023: Retrying in 6 seconds
20:08:52  114dde0fefeb: Retrying in 6 seconds
20:08:52  4d049f83d9cf: Retrying in 6 seconds
20:08:53  4840c7c54023: Retrying in 5 seconds
20:08:53  114dde0fefeb: Retrying in 5 seconds
20:08:53  4d049f83d9cf: Retrying in 5 seconds
20:08:54  4840c7c54023: Retrying in 4 seconds
20:08:54  114dde0fefeb: Retrying in 4 seconds
20:08:55  6f1cdceb6a31: Retrying in 10 seconds
20:08:55  4d049f83d9cf: Retrying in 4 seconds
20:08:55  4840c7c54023: Retrying in 3 seconds
20:08:55  114dde0fefeb: Retrying in 3 seconds
20:08:55  6f1cdceb6a31: Retrying in 9 seconds
20:08:55  4d049f83d9cf: Retrying in 3 seconds
20:08:56  4840c7c54023: Retrying in 2 seconds
20:08:56  114dde0fefeb: Retrying in 2 seconds
20:08:56  6f1cdceb6a31: Retrying in 8 seconds
20:08:56  4d049f83d9cf: Retrying in 2 seconds
20:08:57  4840c7c54023: Retrying in 1 second
20:08:57  114dde0fefeb: Retrying in 1 second
20:08:57  6f1cdceb6a31: Retrying in 7 seconds
20:08:57  4d049f83d9cf: Retrying in 1 second
20:08:58  6f1cdceb6a31: Retrying in 6 seconds
20:08:59  6f1cdceb6a31: Retrying in 5 seconds
20:09:01  6f1cdceb6a31: Retrying in 4 seconds
20:09:02  6f1cdceb6a31: Retrying in 3 seconds
20:09:03  6f1cdceb6a31: Retrying in 2 seconds
20:09:03  6f1cdceb6a31: Retrying in 1 second
20:09:05  114dde0fefeb: Retrying in 15 seconds
20:09:06  4d049f83d9cf: Retrying in 15 seconds
20:09:06  114dde0fefeb: Retrying in 14 seconds
20:09:07  4d049f83d9cf: Retrying in 14 seconds
20:09:07  114dde0fefeb: Retrying in 13 seconds
20:09:08  4d049f83d9cf: Retrying in 13 seconds
20:09:08  114dde0fefeb: Retrying in 12 seconds
20:09:09  4d049f83d9cf: Retrying in 12 seconds
20:09:09  114dde0fefeb: Retrying in 11 seconds
20:09:10  4d049f83d9cf: Retrying in 11 seconds
20:09:10  114dde0fefeb: Retrying in 10 seconds
20:09:11  4d049f83d9cf: Retrying in 10 seconds
20:09:11  6f1cdceb6a31: Retrying in 15 seconds
20:09:11  114dde0fefeb: Retrying in 9 seconds
20:09:12  4d049f83d9cf: Retrying in 9 seconds
20:09:12  6f1cdceb6a31: Retrying in 14 seconds
20:09:12  114dde0fefeb: Retrying in 8 seconds
20:09:13  4840c7c54023: Pushed
20:09:13  4d049f83d9cf: Retrying in 8 seconds
20:09:13  6f1cdceb6a31: Retrying in 13 seconds
20:09:13  114dde0fefeb: Retrying in 7 seconds
20:09:14  4d049f83d9cf: Retrying in 7 seconds
20:09:14  6f1cdceb6a31: Retrying in 12 seconds
20:09:14  114dde0fefeb: Retrying in 6 seconds
20:09:15  4d049f83d9cf: Retrying in 6 seconds
20:09:15  6f1cdceb6a31: Retrying in 11 seconds
20:09:15  114dde0fefeb: Retrying in 5 seconds
20:09:16  4d049f83d9cf: Retrying in 5 seconds
20:09:16  6f1cdceb6a31: Retrying in 10 seconds
20:09:16  114dde0fefeb: Retrying in 4 seconds
20:09:17  4d049f83d9cf: Retrying in 4 seconds
20:09:17  6f1cdceb6a31: Retrying in 9 seconds
20:09:17  114dde0fefeb: Retrying in 3 seconds
20:09:18  4d049f83d9cf: Retrying in 3 seconds
20:09:18  6f1cdceb6a31: Retrying in 8 seconds
20:09:18  114dde0fefeb: Retrying in 2 seconds
20:09:19  4d049f83d9cf: Retrying in 2 seconds
20:09:19  6f1cdceb6a31: Retrying in 7 seconds
20:09:19  114dde0fefeb: Retrying in 1 second
20:09:20  4d049f83d9cf: Retrying in 1 second
20:09:20  6f1cdceb6a31: Retrying in 6 seconds
20:09:21  6f1cdceb6a31: Retrying in 5 seconds
20:09:22  6f1cdceb6a31: Retrying in 4 seconds
20:09:23  6f1cdceb6a31: Retrying in 3 seconds
20:09:24  114dde0fefeb: Retrying in 20 seconds
20:09:24  6f1cdceb6a31: Retrying in 2 seconds
20:09:25  114dde0fefeb: Retrying in 19 seconds
20:09:25  6f1cdceb6a31: Retrying in 1 second
20:09:26  114dde0fefeb: Retrying in 18 seconds
20:09:26  4d049f83d9cf: Pushed
20:09:27  114dde0fefeb: Retrying in 17 seconds
20:09:28  114dde0fefeb: Retrying in 16 seconds
20:09:29  114dde0fefeb: Retrying in 15 seconds
20:09:30  114dde0fefeb: Retrying in 14 seconds
20:09:31  114dde0fefeb: Retrying in 13 seconds
20:09:32  114dde0fefeb: Retrying in 12 seconds
20:09:32  6f1cdceb6a31: Retrying in 20 seconds
20:09:33  114dde0fefeb: Retrying in 11 seconds
20:09:33  6f1cdceb6a31: Retrying in 19 seconds
20:09:34  114dde0fefeb: Retrying in 10 seconds
20:09:34  6f1cdceb6a31: Retrying in 18 seconds
20:09:35  114dde0fefeb: Retrying in 9 seconds
20:09:35  6f1cdceb6a31: Retrying in 17 seconds
20:09:36  114dde0fefeb: Retrying in 8 seconds
20:09:36  6f1cdceb6a31: Retrying in 16 seconds
20:09:37  114dde0fefeb: Retrying in 7 seconds
20:09:37  6f1cdceb6a31: Retrying in 15 seconds
20:09:38  114dde0fefeb: Retrying in 6 seconds
20:09:38  6f1cdceb6a31: Retrying in 14 seconds
20:09:39  114dde0fefeb: Retrying in 5 seconds
20:09:39  6f1cdceb6a31: Retrying in 13 seconds
20:09:40  114dde0fefeb: Retrying in 4 seconds
20:09:40  6f1cdceb6a31: Retrying in 12 seconds
20:09:41  114dde0fefeb: Retrying in 3 seconds
20:09:41  6f1cdceb6a31: Retrying in 11 seconds
20:09:42  114dde0fefeb: Retrying in 2 seconds
20:09:42  6f1cdceb6a31: Retrying in 10 seconds
20:09:43  114dde0fefeb: Retrying in 1 second
20:09:43  6f1cdceb6a31: Retrying in 9 seconds
20:09:44  6f1cdceb6a31: Retrying in 8 seconds
20:09:45  6f1cdceb6a31: Retrying in 7 seconds
20:09:46  6f1cdceb6a31: Retrying in 6 seconds
20:09:47  6f1cdceb6a31: Retrying in 5 seconds
20:09:48  6f1cdceb6a31: Retrying in 4 seconds
20:09:49  6f1cdceb6a31: Retrying in 3 seconds
20:09:50  6f1cdceb6a31: Retrying in 2 seconds
20:09:50  114dde0fefeb: Pushed
20:09:51  6f1cdceb6a31: Retrying in 1 second
20:10:03  EOF
20:10:03  + echo push failed, retry 1 ...
20:10:03  push failed, retry 1 ...
20:10:03  + sleep 5
20:10:06  + docker push ghcr.io/alastairyuan/demo-ci-go:b59881b
20:10:11  The push refers to repository [ghcr.io/alastairyuan/demo-ci-go]
20:10:13  a3640b9fa24b: Preparing
20:10:13  33b37ab0b090: Preparing
20:10:13  6e7fbcf090d0: Preparing
20:10:13  1a73b54f556b: Preparing
20:10:13  4cde6b0bb6f5: Preparing
20:10:13  bd3cdfae1d3f: Preparing
20:10:13  6f1cdceb6a31: Preparing
20:10:13  af5aa97ebe6c: Preparing
20:10:13  4d049f83d9cf: Preparing
20:10:13  114dde0fefeb: Preparing
20:10:13  4840c7c54023: Preparing
20:10:13  8fa10c0194df: Preparing
20:10:13  bff7f7a9d443: Preparing
20:10:13  af5aa97ebe6c: Waiting
20:10:13  4d049f83d9cf: Waiting
20:10:13  114dde0fefeb: Waiting
20:10:13  4840c7c54023: Waiting
20:10:13  bd3cdfae1d3f: Waiting
20:10:13  6f1cdceb6a31: Waiting
20:10:13  8fa10c0194df: Waiting
20:10:13  bff7f7a9d443: Waiting
20:10:21  a3640b9fa24b: Retrying in 5 seconds
20:10:21  a3640b9fa24b: Retrying in 4 seconds
20:10:22  a3640b9fa24b: Retrying in 3 seconds
20:10:22  1a73b54f556b: Layer already exists
20:10:23  a3640b9fa24b: Retrying in 2 seconds
20:10:24  a3640b9fa24b: Retrying in 1 second
20:10:28  33b37ab0b090: Retrying in 5 seconds
20:10:28  a3640b9fa24b: Retrying in 10 seconds
20:10:29  33b37ab0b090: Retrying in 4 seconds
20:10:29  a3640b9fa24b: Retrying in 9 seconds
20:10:30  33b37ab0b090: Retrying in 3 seconds
20:10:30  a3640b9fa24b: Retrying in 8 seconds
20:10:31  33b37ab0b090: Retrying in 2 seconds
20:10:31  a3640b9fa24b: Retrying in 7 seconds
20:10:32  33b37ab0b090: Retrying in 1 second
20:10:32  a3640b9fa24b: Retrying in 6 seconds
20:10:33  6e7fbcf090d0: Retrying in 5 seconds
20:10:33  4cde6b0bb6f5: Retrying in 5 seconds
20:10:33  a3640b9fa24b: Retrying in 5 seconds
20:10:34  6e7fbcf090d0: Retrying in 4 seconds
20:10:34  4cde6b0bb6f5: Retrying in 4 seconds
20:10:34  a3640b9fa24b: Retrying in 4 seconds
20:10:35  bd3cdfae1d3f: Pushed
20:10:35  6e7fbcf090d0: Retrying in 3 seconds
20:10:35  4cde6b0bb6f5: Retrying in 3 seconds
20:10:35  a3640b9fa24b: Retrying in 3 seconds
20:10:36  6e7fbcf090d0: Retrying in 2 seconds
20:10:36  4cde6b0bb6f5: Retrying in 2 seconds
20:10:36  a3640b9fa24b: Retrying in 2 seconds
20:10:37  6f1cdceb6a31: Layer already exists
20:10:37  6e7fbcf090d0: Retrying in 1 second
20:10:37  4cde6b0bb6f5: Retrying in 1 second
20:10:37  a3640b9fa24b: Retrying in 1 second
20:10:40  af5aa97ebe6c: Layer already exists
20:10:41  4d049f83d9cf: Layer already exists
20:10:42  114dde0fefeb: Layer already exists
20:10:44  4840c7c54023: Layer already exists
20:10:44  4cde6b0bb6f5: Pushed
20:10:44  33b37ab0b090: Pushed
20:10:44  8fa10c0194df: Layer already exists
20:10:48  a3640b9fa24b: Retrying in 15 seconds
20:10:48  6e7fbcf090d0: Retrying in 10 seconds
20:10:48  a3640b9fa24b: Retrying in 14 seconds
20:10:49  6e7fbcf090d0: Retrying in 9 seconds
20:10:49  a3640b9fa24b: Retrying in 13 seconds
20:10:50  6e7fbcf090d0: Retrying in 8 seconds
20:10:51  a3640b9fa24b: Retrying in 12 seconds
20:10:51  6e7fbcf090d0: Retrying in 7 seconds
20:10:51  a3640b9fa24b: Retrying in 11 seconds
20:10:52  6e7fbcf090d0: Retrying in 6 seconds
20:10:52  a3640b9fa24b: Retrying in 10 seconds
20:10:53  6e7fbcf090d0: Retrying in 5 seconds
20:10:54  a3640b9fa24b: Retrying in 9 seconds
20:10:54  bff7f7a9d443: Retrying in 5 seconds
20:10:54  6e7fbcf090d0: Retrying in 4 seconds
20:10:54  a3640b9fa24b: Retrying in 8 seconds
20:10:54  bff7f7a9d443: Retrying in 4 seconds
20:10:55  6e7fbcf090d0: Retrying in 3 seconds
20:10:56  a3640b9fa24b: Retrying in 7 seconds
20:10:56  bff7f7a9d443: Retrying in 3 seconds
20:10:56  6e7fbcf090d0: Retrying in 2 seconds
20:10:56  a3640b9fa24b: Retrying in 6 seconds
20:10:56  bff7f7a9d443: Retrying in 2 seconds
20:10:57  6e7fbcf090d0: Retrying in 1 second
20:10:57  a3640b9fa24b: Retrying in 5 seconds
20:10:57  bff7f7a9d443: Retrying in 1 second
20:10:58  a3640b9fa24b: Retrying in 4 seconds
20:10:59  a3640b9fa24b: Retrying in 3 seconds
20:11:01  a3640b9fa24b: Retrying in 2 seconds
20:11:01  6e7fbcf090d0: Retrying in 15 seconds
20:11:01  a3640b9fa24b: Retrying in 1 second
20:11:02  6e7fbcf090d0: Retrying in 14 seconds
20:11:03  6e7fbcf090d0: Retrying in 13 seconds
20:11:04  6e7fbcf090d0: Retrying in 12 seconds
20:11:06  6e7fbcf090d0: Retrying in 11 seconds
20:11:06  bff7f7a9d443: Retrying in 10 seconds
20:11:06  a3640b9fa24b: Retrying in 20 seconds
20:11:06  6e7fbcf090d0: Retrying in 10 seconds
20:11:07  bff7f7a9d443: Retrying in 9 seconds
20:11:07  a3640b9fa24b: Retrying in 19 seconds
20:11:07  6e7fbcf090d0: Retrying in 9 seconds
20:11:08  bff7f7a9d443: Retrying in 8 seconds
20:11:08  a3640b9fa24b: Retrying in 18 seconds
20:11:08  6e7fbcf090d0: Retrying in 8 seconds
20:11:09  bff7f7a9d443: Retrying in 7 seconds
20:11:09  a3640b9fa24b: Retrying in 17 seconds
20:11:09  6e7fbcf090d0: Retrying in 7 seconds
20:11:10  bff7f7a9d443: Retrying in 6 seconds
20:11:10  a3640b9fa24b: Retrying in 16 seconds
20:11:10  6e7fbcf090d0: Retrying in 6 seconds
20:11:11  bff7f7a9d443: Retrying in 5 seconds
20:11:11  a3640b9fa24b: Retrying in 15 seconds
20:11:11  6e7fbcf090d0: Retrying in 5 seconds
20:11:12  bff7f7a9d443: Retrying in 4 seconds
20:11:12  a3640b9fa24b: Retrying in 14 seconds
20:11:12  6e7fbcf090d0: Retrying in 4 seconds
20:11:13  bff7f7a9d443: Retrying in 3 seconds
20:11:13  a3640b9fa24b: Retrying in 13 seconds
20:11:13  6e7fbcf090d0: Retrying in 3 seconds
20:11:14  bff7f7a9d443: Retrying in 2 seconds
20:11:14  a3640b9fa24b: Retrying in 12 seconds
20:11:14  6e7fbcf090d0: Retrying in 2 seconds
20:11:15  bff7f7a9d443: Retrying in 1 second
20:11:15  a3640b9fa24b: Retrying in 11 seconds
20:11:15  6e7fbcf090d0: Retrying in 1 second
20:11:16  a3640b9fa24b: Retrying in 10 seconds
20:11:17  a3640b9fa24b: Retrying in 9 seconds
20:11:18  a3640b9fa24b: Retrying in 8 seconds
20:11:19  a3640b9fa24b: Retrying in 7 seconds
20:11:20  6e7fbcf090d0: Retrying in 20 seconds
20:11:20  a3640b9fa24b: Retrying in 6 seconds
20:11:21  bff7f7a9d443: Retrying in 15 seconds
20:11:21  6e7fbcf090d0: Retrying in 19 seconds
20:11:21  a3640b9fa24b: Retrying in 5 seconds
20:11:22  bff7f7a9d443: Retrying in 14 seconds
20:11:22  6e7fbcf090d0: Retrying in 18 seconds
20:11:22  a3640b9fa24b: Retrying in 4 seconds
20:11:23  bff7f7a9d443: Retrying in 13 seconds
20:11:23  6e7fbcf090d0: Retrying in 17 seconds
20:11:23  a3640b9fa24b: Retrying in 3 seconds
20:11:24  bff7f7a9d443: Retrying in 12 seconds
20:11:24  6e7fbcf090d0: Retrying in 16 seconds
20:11:24  a3640b9fa24b: Retrying in 2 seconds
20:11:25  bff7f7a9d443: Retrying in 11 seconds
20:11:25  6e7fbcf090d0: Retrying in 15 seconds
20:11:25  a3640b9fa24b: Retrying in 1 second
20:11:26  bff7f7a9d443: Retrying in 10 seconds
20:11:26  6e7fbcf090d0: Retrying in 14 seconds
20:11:27  bff7f7a9d443: Retrying in 9 seconds
20:11:27  6e7fbcf090d0: Retrying in 13 seconds
20:11:28  bff7f7a9d443: Retrying in 8 seconds
20:11:28  6e7fbcf090d0: Retrying in 12 seconds
20:11:29  bff7f7a9d443: Retrying in 7 seconds
20:11:29  6e7fbcf090d0: Retrying in 11 seconds
20:11:30  bff7f7a9d443: Retrying in 6 seconds
20:11:30  6e7fbcf090d0: Retrying in 10 seconds
20:11:31  bff7f7a9d443: Retrying in 5 seconds
20:11:31  6e7fbcf090d0: Retrying in 9 seconds
20:11:32  bff7f7a9d443: Retrying in 4 seconds
20:11:32  6e7fbcf090d0: Retrying in 8 seconds
20:11:33  bff7f7a9d443: Retrying in 3 seconds
20:11:33  6e7fbcf090d0: Retrying in 7 seconds
20:11:33  EOF
20:11:33  + echo push failed, retry 2 ...
20:11:33  push failed, retry 2 ...
20:11:33  + sleep 5
20:11:38  + docker push ghcr.io/alastairyuan/demo-ci-go:b59881b
20:11:43  The push refers to repository [ghcr.io/alastairyuan/demo-ci-go]
20:11:43  a3640b9fa24b: Preparing
20:11:43  33b37ab0b090: Preparing
20:11:43  6e7fbcf090d0: Preparing
20:11:43  1a73b54f556b: Preparing
20:11:43  4cde6b0bb6f5: Preparing
20:11:43  bd3cdfae1d3f: Preparing
20:11:43  6f1cdceb6a31: Preparing
20:11:43  af5aa97ebe6c: Preparing
20:11:43  4d049f83d9cf: Preparing
20:11:43  114dde0fefeb: Preparing
20:11:43  4840c7c54023: Preparing
20:11:43  8fa10c0194df: Preparing
20:11:43  bff7f7a9d443: Preparing
20:11:43  af5aa97ebe6c: Waiting
20:11:43  4d049f83d9cf: Waiting
20:11:43  114dde0fefeb: Waiting
20:11:43  4840c7c54023: Waiting
20:11:43  8fa10c0194df: Waiting
20:11:43  bff7f7a9d443: Waiting
20:11:43  bd3cdfae1d3f: Waiting
20:11:43  6f1cdceb6a31: Waiting
20:11:46  6e7fbcf090d0: Layer already exists
20:11:46  a3640b9fa24b: Layer already exists
20:11:46  4cde6b0bb6f5: Layer already exists
20:11:46  33b37ab0b090: Layer already exists
20:11:46  1a73b54f556b: Layer already exists
20:11:47  6f1cdceb6a31: Layer already exists
20:11:47  4d049f83d9cf: Layer already exists
20:11:47  af5aa97ebe6c: Layer already exists
20:11:52  4840c7c54023: Layer already exists
20:11:54  bd3cdfae1d3f: Pushed
20:11:54  8fa10c0194df: Pushed
20:11:55  114dde0fefeb: Pushed
20:11:57  bff7f7a9d443: Pushed
20:12:07  Head "https://ghcr.io/v2/alastairyuan/demo-ci-go/blobs/sha256:b3e0dde6e3b04efe023017a52e15be29a819a15583807d036d979043e01e12e0": EOF
20:12:07  + echo push failed, retry 3 ...
20:12:07  push failed, retry 3 ...
20:12:07  + sleep 5
20:12:11  + docker push ghcr.io/alastairyuan/demo-ci-go:latest
20:12:16  The push refers to repository [ghcr.io/alastairyuan/demo-ci-go]
20:12:16  a3640b9fa24b: Preparing
20:12:16  33b37ab0b090: Preparing
20:12:16  6e7fbcf090d0: Preparing
20:12:16  1a73b54f556b: Preparing
20:12:16  4cde6b0bb6f5: Preparing
20:12:16  bd3cdfae1d3f: Preparing
20:12:16  6f1cdceb6a31: Preparing
20:12:16  af5aa97ebe6c: Preparing
20:12:16  4d049f83d9cf: Preparing
20:12:16  114dde0fefeb: Preparing
20:12:16  4840c7c54023: Preparing
20:12:16  8fa10c0194df: Preparing
20:12:16  bff7f7a9d443: Preparing
20:12:16  af5aa97ebe6c: Waiting
20:12:16  4d049f83d9cf: Waiting
20:12:16  114dde0fefeb: Waiting
20:12:16  4840c7c54023: Waiting
20:12:16  bd3cdfae1d3f: Waiting
20:12:16  6f1cdceb6a31: Waiting
20:12:16  8fa10c0194df: Waiting
20:12:16  bff7f7a9d443: Waiting
20:12:18  1a73b54f556b: Layer already exists
20:12:19  a3640b9fa24b: Layer already exists
20:12:19  4cde6b0bb6f5: Layer already exists
20:12:19  33b37ab0b090: Layer already exists
20:12:19  6e7fbcf090d0: Layer already exists
20:12:20  bd3cdfae1d3f: Layer already exists
20:12:20  6f1cdceb6a31: Layer already exists
20:12:20  af5aa97ebe6c: Layer already exists
20:12:20  114dde0fefeb: Layer already exists
20:12:20  4d049f83d9cf: Layer already exists
20:12:21  bff7f7a9d443: Layer already exists
20:12:21  8fa10c0194df: Layer already exists
20:12:21  4840c7c54023: Layer already exists
20:12:24  latest: digest: sha256:b984063acac2f9a33d44030fe384bccc7cbb511db40c7eb5094055ac13cc9d0d size: 3019
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] sh
20:12:25  + set +e
20:12:25  + docker logout ghcr.io
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // timestamps
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
