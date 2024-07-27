# Development

## devcontainer

- The `org.freebsd.secrets` service is missing for `keytar`.
- It must be `x11` on a Wayland host; there seems to be a problem with VSCode's Wayland forwarding.

## `anytype-ts`

```sh
cd ../anytype-heart
make setup-protoc
make install-dev-js

cd ../anytype-ts
npm run start:watch
npm run start:electron-wait-webpack
```
