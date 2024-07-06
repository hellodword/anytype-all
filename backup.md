# Backup

**DO NOT LET MNEMONIC LEAVE YOUR TRUSTED DEVICE !!!**

Here's how it works:

1. It runs a headless AnyType client with `github.com/anyproto/anytype-heart/cmd/grpcserver`.
2. It recovers the wallet using the mnemonic.
3. It selects your account and backs up the default space.

```sh
vim .env
# ANYTYPE_MNEMONIC=...
# ANYTYPE_ACCOUNT_ID=...

docker build -t anytype-backup -f ./docker/backup.Dockerfile .

docker run -d --rm --name anytype-backup -v ~/.config/anytype:/data:ro --env-file .env -v /tmp:/output anytype-backup

docker exec anytype-backup /scripts/backup.sh

docker kill anytype-backup
```

## TODO

- [ ] Restore
- [ ] Backup all spaces
- [ ] Automatically detect the account ID
