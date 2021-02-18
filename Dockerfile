FROM golang:1.15 AS builder

RUN go get -u github.com/benvanmierloo/vitotrol2mqtt

FROM arm32v7/ubuntu

RUN apt update && apt install -y ca-certificates

COPY --from=builder /go/bin/vitotrol2mqtt /vitotrol2mqtt

ENTRYPOINT ["/vitotrol2mqtt", "-config", "/vitotrol2mqtt.yml"]
