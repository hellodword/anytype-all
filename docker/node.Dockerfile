FROM golang:bookworm AS builder

ARG ANY_SYNC_NODE_VERSION="v0.4.13"

RUN git clone --depth=1 -b ${ANY_SYNC_NODE_VERSION} https://github.com/anyproto/any-sync-node /usr/src/app

WORKDIR /usr/src/app

RUN go mod download && go mod verify

RUN go build -x -v -trimpath -ldflags "-s -w -X github.com/anyproto/any-sync/app.AppName=any-sync-node" -buildvcs=false -o /usr/local/bin/any-sync-node ./cmd

FROM gcr.io/distroless/base-debian12

COPY --from=builder /usr/local/bin/any-sync-node /usr/local/bin/any-sync-node

WORKDIR /app

CMD ["/usr/local/bin/any-sync-node", "-c", "/app/config.yml"]
