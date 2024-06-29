# anytype-all

I want to migrate my notes and to-dos to Anytype for long-term use. Before doing so, I need to make sure it is secure and reliable.

## development status

Based on what I can see, it seems quite active.

- https://community.anytype.io/t/development-pace-roadmap-for-2025/22101/10
- https://github.com/anyproto/anytype-ts/pulse
- https://github.com/anyproto/anytype-swift/pulse

## open source

The clients are not really open source; they use the `Any Source Available License`, but I am using it for non-commercial purposes, so it is acceptable for me.

- https://github.com/orgs/anyproto/discussions/1
- https://legal.any.coop/
- https://github.com/anyproto/anytype-ts/issues/79#issuecomment-1648571661

## design & tech

- https://github.com/anyproto/tech-docs

- any-sync[protocol]: https://tech.anytype.io/any-sync/overview
  - any-sync-node
  - any-sync-filenode
  - any-sync-consensusnode
  - any-sync-coordinator
- any-block[protocol]: https://github.com/anyproto/any-block
- anytype-heart

## Security

- https://doc.anytype.io/anytype-docs/data-and-security/how-we-keep-your-data-safe
- MITM
- reproducible builds (verify the AppImage): https://github.com/anyproto/anytype-ts/issues/793
- audit the protocols and implementations
- audit the clients' dependencies
- threat model

## Analytics & Tracking

It's possible to disable analytics and tracking through firewall rules or patches, and an option to disable them will be available.

- https://doc.anytype.io/anytype-docs/data-and-security/analytics-and-tracking
- https://github.com/orgs/anyproto/projects/1/views/1?pane=issue&itemId=29227689

---

## client

### NixOS

- pkg
  - https://github.com/NixOS/nixpkgs/tree/master/pkgs/by-name/an/anytype
  - https://github.com/nix-community/nur-combined/tree/master/repos/kira-bruneau/pkgs/development/tools/misc/anytype
  - https://github.com/squalus/anytype-flake
- keyring: use the option from nixos module, not hm
  - https://github.com/nix-community/home-manager/issues/1454

### local backup

Maybe `~/.config/anytype/data`? Not sure.

### firewall

- https://github.com/orgs/anyproto/discussions/206
- https://github.com/anyproto/anytype-heart/blob/6f52f45a6a4caaad384080f291f43276c39cec4e/core/anytype/config/nodes/production.yml

---

## self-hosted

- https://tech.anytype.io/how-to/self-hosting
- https://github.com/orgs/anyproto/discussions/categories/self-hosting?discussions_q=category%3ASelf-hosting+
- https://github.com/orgs/anyproto/discussions/17
- https://github.com/anyproto/any-sync-dockercompose
- https://github.com/anyproto/ansible-anysync
- https://forge.puppetlabs.com/modules/anyproto/anysync/readme

The official scripts are somewhat heavy:

```
$ docker compose stats --no-stream --format "table {{.Name}}\t{{.MemUsage}}"
NAME                                                 MEM USAGE
any-sync-dockercompose-netcheck-1                    19.05MiB
any-sync-dockercompose-any-sync-node-1-1             31.32MiB
any-sync-dockercompose-any-sync-filenode-1           43.5MiB
any-sync-dockercompose-any-sync-consensusnode-1      33.27MiB
any-sync-dockercompose-any-sync-coordinator-1        35.17MiB

any-sync-dockercompose-generateconfig-processing-1   20.54MiB
any-sync-dockercompose-generateconfig-anyconf-1      25.71MiB

any-sync-dockercompose-any-sync-node-3-1             31.77MiB
any-sync-dockercompose-any-sync-node-2-1             32MiB
any-sync-dockercompose-minio-1                       183.1MiB
any-sync-dockercompose-mongo-1-1                     308.5MiB
any-sync-dockercompose-redis-1                       26.3MiB
```

With [several patches](https://github.com/anyproto/any-sync-dockercompose/pulls?q=is%3Apr+author%3Ahellodword) (or [the forked brach](https://github.com/hellodword/any-sync-dockercompose/tree/hellodword)), I am able to run a self-hosted instance without Minio and with only 1 sync node:

```
any-sync-dockercompose-any-sync-filenode-1       46.36MiB
any-sync-dockercompose-any-sync-node-1-1         42.11MiB
any-sync-dockercompose-any-sync-consensusnode-1  32.97MiB
any-sync-dockercompose-any-sync-coordinator-1    34.48MiB
any-sync-dockercompose-mongo-1-1                 308.6MiB
any-sync-dockercompose-redis-1                   26.69MiB
```

Usage:

```sh
cat >> .env.override << EOF
ANY_SYNC_FILENODE_USE_DEV=true
ANY_SYNC_DISABLE_NETCHECK=true
ANY_SYNC_HELLODWORD=true
EOF
```

MongoDB is the last heavy container, but it is not easy to remove at this time.

---

## TODO

- deploy

  - [ ] generate network, keys and config files
  - [ ] docker compose

- `any-sync-filenode`

  - [ ] [Reduce s3 PUT/GET requests](https://github.com/anyproto/any-sync-filenode/issues/118)
  - [x] use fsstore instead of s3store: https://github.com/anyproto/any-sync-filenode/blob/df4bb417e7ea76c80663ff18ba1f2d8d7a32c7e3/cmd/store.go#L1

    ```sh
    go build -x -v -trimpath -ldflags "-s -w" -buildvcs=false -o any-sync-filenode -tags dev ./cmd
    ```

  - [ ] optional redis

- `any-sync-coordinator`

  - [ ] [loose coupling MongoDB](https://github.com/anyproto/any-sync-coordinator/issues/80)

- `any-sync-consensusnode`

  - [ ] [loose coupling MongoDB](https://github.com/anyproto/any-sync-coordinator/issues/80)
  - [ ] Add https://github.com/256dpi/lungo
  - [ ] ~~Use FerretDB+Sqlite https://github.com/FerretDB/FerretDB~~
    > not working, see:
    - https://github.com/FerretDB/FerretDB/blob/main/website/docs/reference/supported-commands.md
    - https://github.com/FerretDB/FerretDB/blob/main/website/docs/diff.md

- `any-sync-node`

- P2P

  - [ ] [Debug] show the P2P status: https://github.com/anyproto/anytype-heart/issues/1341
  - [ ] configure peers manually for tailscale: https://github.com/anyproto/anytype-heart/issues/1341

- [Limit users on a self hosted instance](https://github.com/orgs/anyproto/discussions/193)

  > I use it with tailscale, so it's unnecessary for me.

- backup

  - https://www.mongodb.com/docs/database-tools/mongodump/
