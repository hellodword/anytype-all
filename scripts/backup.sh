#! /usr/bin/env bash

: ${DATA_PATH:="$HOME/.config/anytype"}
: ${OUTPUT_PATH:="/tmp"}
: ${ANYTYPE_GRPC_ADDR:="localhost:61234"}
: ${ANYTYPE_HEART_PROTOSET:="dist/service.proto.bundle"}
: ${ANYTYPE_HELPER:="anytypeHelper"}
: ${GRPCURL:="grpcurl"}

if [[ -z "$ANYTYPE_MNEMONIC" ]]; then
  echo "the ANYTYPE_MNEMONIC is empty"
  exit 1
fi

if [[ -z "$ANYTYPE_ACCOUNT_ID" ]]; then
  echo "the ANYTYPE_ACCOUNT_ID is empty"
  exit 1
fi

if [ ! -d "$DATA_PATH" ]; then
  echo "the DATA_PATH $DATA_PATH does not exist"
  exit 1
fi

if [ ! -f "$ANYTYPE_HEART_PROTOSET" ]; then
  echo "the ANYTYPE_HEART_PROTOSET $ANYTYPE_HEART_PROTOSET does not exist"
  exit 1
fi

TMP_DIR="$(realpath $(mktemp -d -t anytype-backup-XXXXXX))"
ROOT_PATH="$TMP_DIR/target"

echo "ROOT_PATH $ROOT_PATH"

cp -r "$DATA_PATH" "$ROOT_PATH"

while true; do
  sleep 1s
  res=$("$GRPCURL" -protoset "$ANYTYPE_HEART_PROTOSET" -plaintext -d '{}' "$ANYTYPE_GRPC_ADDR" anytype.ClientCommands.AppGetVersion)
  if [ -z "$(echo "$res" | jq -r '.version')" ]; then
    continue
  fi
  break
done

body="$(jq -nc --arg rootPath "$ROOT_PATH" --arg mnemonic "$ANYTYPE_MNEMONIC" '{"rootPath": $rootPath, "mnemonic": $mnemonic}')"
res=$("$GRPCURL" -protoset "$ANYTYPE_HEART_PROTOSET" -plaintext -d "$body" "$ANYTYPE_GRPC_ADDR" anytype.ClientCommands.WalletRecover)
echo "$res"
if [ "$(echo "$res" | jq -r '.error')" != "{}" ]; then
  echo "WalletRecover $res"
  exit 1
fi

body="$(jq -nc --arg mnemonic "$ANYTYPE_MNEMONIC" '{"mnemonic": $mnemonic}')"
res=$("$GRPCURL" -protoset "$ANYTYPE_HEART_PROTOSET" -plaintext -d "$body" "$ANYTYPE_GRPC_ADDR" anytype.ClientCommands.WalletCreateSession)
token="$(echo "$res" | jq -r '.token')"
if [ -z "$token" ]; then
  echo "WalletCreateSession $res"
  exit 1
fi

res=$("$GRPCURL" -rpc-header "token: $token" -protoset "$ANYTYPE_HEART_PROTOSET" -plaintext -d '{"platform": "linux", "version": "1.0"}' "$ANYTYPE_GRPC_ADDR" anytype.ClientCommands.MetricsSetParameters)
echo "$res"
if [ "$(echo "$res" | jq -r '.error')" != "{}" ]; then
  echo "MetricsSetParameters $res"
  exit 1
fi

body="$(jq -nc --arg id "$ANYTYPE_ACCOUNT_ID" --arg rootPath "$ROOT_PATH/data/$ANYTYPE_ACCOUNT_ID" '{"id": $id, "rootPath": $rootPath, "disableLocalNetworkSync": true, "networkMode": 1}')"
res=$("$GRPCURL" -rpc-header "token: $token" -protoset "$ANYTYPE_HEART_PROTOSET" -plaintext -d "$body" "$ANYTYPE_GRPC_ADDR" anytype.ClientCommands.AccountSelect)
accountSpaceId="$(echo "$res" | jq -r '.account.info.accountSpaceId')"
if [ -z "$accountSpaceId" ]; then
  echo "AccountSelect $res"
  exit 1
fi

body="$(jq -nc --arg id "$accountSpaceId" --arg path "$OUTPUT_PATH" '{"spaceId": $id, "path": $path, "format": "JSON", "zip": true, "includeNested": true, "includeFiles": true, "includeArchived": true}')"
res=$("$GRPCURL" -rpc-header "token: $token" -protoset "$ANYTYPE_HEART_PROTOSET" -plaintext -d "$body" "$ANYTYPE_GRPC_ADDR" anytype.ClientCommands.ObjectListExport)
echo "$res"
if [ "$(echo "$res" | jq -r '.error')" != "{}" ]; then
  exit 1
fi
