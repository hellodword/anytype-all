FROM golang:bookworm AS builder

ARG ANY_SYNC_FILENODE_VERSION

RUN git clone --depth=1 -b ${ANY_SYNC_FILENODE_VERSION} https://github.com/anyproto/any-sync-filenode /usr/src/app

WORKDIR /usr/src/app

RUN go mod download && go mod verify

RUN go build -x -v -trimpath -ldflags "-s -w -X github.com/anyproto/any-sync/app.AppName=any-sync-filenode" -buildvcs=false -o /usr/local/bin/any-sync-filenode -tags dev ./cmd

FROM gcr.io/distroless/base-debian12

COPY --from=builder /usr/local/bin/any-sync-filenode /usr/local/bin/any-sync-filenode

WORKDIR /app

CMD ["/usr/local/bin/any-sync-filenode", "-c", "/app/config.yml"]
