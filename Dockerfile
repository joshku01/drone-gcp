FROM golang:1.15-alpine AS builder
#enable Go module support
ENV GO111MODULE=on

COPY . /app
WORKDIR /app

#manage dependencies
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy src code from the host and compile it
RUN CGO_ENABLED=0 GOOS=linux go build -o app main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app .
ENV PORT 8080
CMD ["./app"]
#ADD . /go/src/hello-web
#RUN go build
#ENV PORT 8080
#CMD ["./hello-app"]