FROM golang:bookworm as builder

RUN go install github.com/anyproto/any-sync-tools/anyconf@latest

FROM gcr.io/distroless/base-debian12

COPY --from=builder /go/bin/anyconf /usr/local/bin/anyconf

ENTRYPOINT ["/usr/local/bin/anyconf"]
