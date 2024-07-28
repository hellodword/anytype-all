# Development

## devcontainer

- The `org.freebsd.secrets` service is missing for `keytar`.
- It must be `x11` on a Wayland host; there seems to be a problem with VSCode's Wayland forwarding.

## `anytype-ts`

```sh
cd ../anytype-heart
# make setup-protoc
# make setup-protoc-go
# make setup-protoc-jsweb
make protos && make protos-docs && make protos-go && make protos-gomobile && make protos-java && make protos-js && make protos-server
make install-dev-js

cd ../anytype-ts
. .env
npm run start:watch
env MNEMONIC="$MNEMONIC" npm run start:electron-wait-webpack 2>&1 | tee .log
```
