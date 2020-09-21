FROM golang:1.15-alpine AS builder
#enable Go module support
ENV GO111MODULE=on

WORKDIR $GOPATH/src/github.com/hello-web/v1

#manage dependencies
COPY go.mod .
COPY go.sum .
RUN go mod download

ADD . /go/src/hello-app
RUN go install hello-app

FROM alpine:latest
COPY --from=0 /go/bin/hello-app .
ENV PORT 8080
CMD ["./hello-app"]