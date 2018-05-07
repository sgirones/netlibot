FROM golang:1.10.1
WORKDIR /go/src/github.com/netlify/netlibot
COPY . /go/src/github.com/netlify/netlibot/
RUN go get && go build

FROM alpine:3.7
RUN apk add --no-cache ca-certificates
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
COPY --from=0 /go/src/github.com/netlify/netlibot/netlibot /netlibot/netlibot
WORKDIR /netlibot
CMD ["netlibot"]
