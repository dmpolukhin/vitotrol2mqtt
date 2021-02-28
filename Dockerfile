FROM golang:1.15 AS builder

RUN go get -u github.com/dmpolukhin/vitotrol2mqtt

FROM alpine:3.13.2

RUN env CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w -extldflags "-static"'

COPY --from=builder /go/bin/vitotrol2mqtt /vitotrol2mqtt

ENTRYPOINT ["/vitotrol2mqtt", "-config", "/vitotrol2mqtt.yml"]
