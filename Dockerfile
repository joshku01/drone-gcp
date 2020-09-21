FROM golang:1.15-alpine AS builder
#enable Go module support
ENV GO111MODULE=on

WORKDIR $GOPATH/src/github.com/hello-web/v1

#manage dependencies
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy src code from the host and compile it
COPY cmd cmd
COPY pkg pkg
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /hello-web cmd/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /hello-web /bin
CMD ["/bin/myapp"]
#ADD . /go/src/hello-web
#RUN go build
#ENV PORT 8080
#CMD ["./hello-app"]