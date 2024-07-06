FROM golang:bookworm as builder

ARG ANY_SYNC_COORDINATOR_VERSION

RUN git clone --depth=1 https://github.com/anyproto/anytype-heart /usr/src/app && rm -rf .git

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install --yes protobuf-compiler jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
RUN go install ./cmd/grpcserver

RUN protoc --include_imports --proto_path=./ --descriptor_set_out=./dist/service.proto.bundle pb/protos/service/service.proto

ENV DATA_PATH /data
ENV ANYTYPE_GRPC_ADDR localhost:61234
ENV ANYTYPE_HEART_PROTOSET /usr/src/app/dist/service.proto.bundle
ENV ANYTYPE_HELPER /go/bin/grpcserver
ENV GRPCURL /go/bin/grpcurl
ENV OUTPUT_PATH /output

COPY scripts/trap.sh /scripts/trap.sh
COPY scripts/backup.sh /scripts/backup.sh

CMD ["/scripts/trap.sh", "/go/bin/grpcserver"]
