FROM golang:bookworm AS builder

ARG ANY_SYNC_CONSENSUSNODE_VERSION="v0.2.2"

RUN git clone --depth=1 -b ${ANY_SYNC_CONSENSUSNODE_VERSION} https://github.com/anyproto/any-sync-consensusnode /usr/src/app

WORKDIR /usr/src/app

COPY patches /patches

RUN git apply /patches/"any-sync-consensusnode-${ANY_SYNC_CONSENSUSNODE_VERSION}.patch"

RUN go mod download && go mod verify

RUN go build -x -v -trimpath -ldflags "-s -w -X github.com/anyproto/any-sync/app.AppName=any-sync-consensusnode" -buildvcs=false -o /usr/local/bin/any-sync-consensusnode ./cmd

FROM gcr.io/distroless/base-debian12

COPY --from=builder /usr/local/bin/any-sync-consensusnode /usr/local/bin/any-sync-consensusnode

WORKDIR /app

CMD ["/usr/local/bin/any-sync-consensusnode", "-c", "/app/config.yml"]
