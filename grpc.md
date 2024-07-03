# grpc of anytype

```sh
# find the grpc port of the anytype, actually the chrome extension of anytype is using the `lsof` and `grep` which I don't agree
ANYTYPE_GRPC_ADDR=127.0.0.1:43163

# or close the anytype APP and call the grpc server by yourself
env ANYTYPE_GRPC_ADDR=$ANYTYPE_GRPC_ADDR anytypeHelper

# find the space id from anytype
SPACE_ID=the-space-id

git clone --depth=1 https://github.com/anyproto/anytype-heart repos/anytype-heart

alias grpcurl='grpcurl -import-path ./repos/anytype-heart -proto ./repos/anytype-heart/pb/protos/service/service.proto'

# # auth with challenge
grpcurl -plaintext -d '{"appName":"com.anytype.desktop"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.AccountLocalLinkNewChallenge
# {
#   "error": {},
#   "challengeId": "ab0f35282cf1c0e76855aea0"
# }
grpcurl -plaintext -d '{"challengeId":"ab0f35282cf1c0e76855aea0", "answer":"1967"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.AccountLocalLinkSolveChallenge
# {
#   "error": {},
#   "appKey": "the-app-key"
# }
grpcurl -plaintext -d '{"appKey": "the-app-key"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.WalletCreateSession
# {
#   "error": {},
#   "token": "the-token"
# }

# # or auth with mnemonic
grpcurl -plaintext -d '{"rootPath": "/path/to/anytype","mnemonic": "the-mnemonic"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.WalletRecover
# {
#   "error": {}
# }
grpcurl -plaintext -d '{"mnemonic": "the-mnemonic"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.WalletCreateSession
# {
#   "error": {},
#   "token": "the-token"
# }
# # this is required
grpcurl -rpc-header 'token: the-token' -plaintext -d '{"platform": "linux", "version": "1.0"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.MetricsSetParameters
# {
#   "error": {}
# }
grpcurl -rpc-header 'token: the-token' -plaintext -d '{"id": "the-account-id", "rootPath": "/path/to/anytype/data/the-account-id", "disableLocalNetworkSync": true, "networkMode": 1}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.AccountSelect
# {
#   "error": {},
#   "account": {
#     "id": "the-account-id",
#     "info": {
#       "homeObjectId": "...",
#       "archiveObjectId": "...",
#       "profileObjectId": "...",
#       "deviceId": "...",
#       "accountSpaceId": "...",
#       "widgetsId": "...",
#       "marketplaceWorkspaceId": "_anytype_marketplace",
#       "spaceViewId": "...",
#       "techSpaceId": "...",
#       "gatewayUrl": "...",
#       "localStoragePath": "...",
#       "analyticsId": "..."
#     }
#   }
# }

grpcurl -rpc-header "token: the-token" -plaintext -d '{"message": "hello"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.LogSend

grpcurl -rpc-header "token: the-token" -plaintext -d '{"spaceId":"the-space-id","path": "/path/to/a/dir", "format": "JSON", "zip": true, "includeNested": true, "includeFiles": true, "includeArchived": true}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.ObjectListExport
# {
#   "error": {},
#   "path": "/path/to/a/dir/Anytype.20240703.075923.63.zip",
#   "succeed": 198
# }

```


## backup with `anytype-heart` and grpcurl

About the `service.proto.bundle` see: https://github.com/anyproto/anytype-heart/pull/1369

```sh
cp -r $HOME/.config/anytype /path/to/anytype

grpcurl -protoset /path/to/service.proto.bundle -plaintext -d '{"rootPath": "/path/to/anytype","mnemonic": "the-mnemonic"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.WalletRecover

# get token
grpcurl -protoset /path/to/service.proto.bundle -plaintext -d '{"mnemonic": "moral differ farm mobile pluck mean interest marble stage hand unlock belt"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.WalletCreateSession

# required
grpcurl -protoset /path/to/service.proto.bundle -rpc-header 'token: the-token' -plaintext -d '{"platform": "linux", "version": "1.0"}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.MetricsSetParameters

grpcurl -protoset /path/to/service.proto.bundle -rpc-header 'token: the-token' -plaintext -d '{"id": "the-account-id", "rootPath": "/path/to/anytype/data/the-account-id", "disableLocalNetworkSync": true, "networkMode": 1}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.AccountSelect

grpcurl -protoset /path/to/service.proto.bundle -rpc-header 'token: the-token' -plaintext -d '{"spaceId":"the-space-id","path": "/path/to/backup", "format": "JSON", "zip": true, "includeNested": true, "includeFiles": true, "includeArchived": true}' $ANYTYPE_GRPC_ADDR anytype.ClientCommands.ObjectListExport
```
