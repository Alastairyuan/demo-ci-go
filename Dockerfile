# ---------- build stage ----------
FROM golang:1.22 AS builder
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/app .

# ---------- runtime stage ----------
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /out/app /app
USER nonroot:nonroot
ENTRYPOINT ["/app"]
