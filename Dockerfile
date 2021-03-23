# STAGE 1 - criar binário do go
FROM golang:alpine AS builder

WORKDIR /go/app
COPY . .

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/main

# STAGE  2 - construir imagem com binário apenas
FROM scratch
COPY --from=builder /go/bin/main /go/bin/main
ENTRYPOINT ["/go/bin/main"]