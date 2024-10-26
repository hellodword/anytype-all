FROM golang:bookworm AS builder

ARG ANY_SYNC_COORDINATOR_VERSION="v0.4.1"

RUN git clone --depth=1 -b ${ANY_SYNC_COORDINATOR_VERSION} https://github.com/anyproto/any-sync-coordinator /usr/src/app

WORKDIR /usr/src/app

COPY patches /patches

RUN git apply /patches/"any-sync-coordinator-${ANY_SYNC_COORDINATOR_VERSION}.patch"

RUN go mod download && go mod verify

RUN go build -x -v -trimpath -ldflags "-s -w -X github.com/anyproto/any-sync/app.AppName=any-sync-coordinator" -buildvcs=false -o /usr/local/bin/any-sync-coordinator ./cmd/coordinator

FROM gcr.io/distroless/base-debian12

COPY --from=builder /usr/local/bin/any-sync-coordinator /usr/local/bin/any-sync-coordinator

WORKDIR /app

CMD ["/usr/local/bin/any-sync-coordinator", "-c", "/app/config.yml"]
