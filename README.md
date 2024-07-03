# anytype-all

I want to migrate my notes and to-dos to Anytype for long-term use. Before doing so, I need to make sure it is secure and reliable.

## Development Status

Based on what I can see, it seems quite active.

- https://community.anytype.io/t/development-pace-roadmap-for-2025/22101/10
- https://github.com/anyproto/anytype-ts/pulse
- https://github.com/anyproto/anytype-swift/pulse

## Open Source

The clients are not really open source; they use the `Any Source Available License`, but I am using it for non-commercial purposes, so it is acceptable for me.

- https://github.com/orgs/anyproto/discussions/1
- https://legal.any.coop/
- https://github.com/anyproto/anytype-ts/issues/79#issuecomment-1648571661

## Design & Tech

- https://github.com/anyproto/tech-docs

- any-sync[protocol]: https://tech.anytype.io/any-sync/overview
  - any-sync-node
  - any-sync-filenode
  - any-sync-consensusnode
  - any-sync-coordinator
- any-block[protocol]: https://github.com/anyproto/any-block
- anytype-heart

## Security

- reproducible builds: https://github.com/anyproto/anytype-ts/issues/793
- https://doc.anytype.io/anytype-docs/data-and-security/how-we-keep-your-data-safe

For such an app, the security of both the protocols and the clients is a concern. I'm not an expert and can't determine if the protocols are secure. However, there are too many dependencies in the clients, and I don't think they have been well-audited.

However, in the meantime:

1. I use it with a VPN, so the security of the protocols is not a big deal for me.
2. I use the iOS client, while iOS has many built-in security policies.
3. I use [the Linux client with hardening](https://github.com/squalus/anytype-flake/issues/2).

## Analytics & Tracking

It's possible to disable analytics and tracking through firewall rules or patches, and an option to disable them will be available.

- https://doc.anytype.io/anytype-docs/data-and-security/analytics-and-tracking
- https://github.com/orgs/anyproto/projects/1/views/1?pane=issue&itemId=29227689
- firewall
  - https://github.com/orgs/anyproto/discussions/206
  - https://github.com/anyproto/anytype-heart/blob/6f52f45a6a4caaad384080f291f43276c39cec4e/core/anytype/config/nodes/production.yml

## Backup & Restore

Given that the app does not currently provide extended APIs, I'm going to implement a headless client specifically for exporting, backing up, or restoring data. I believe that this process will also deepen my understanding of the entire ecosystem.

- See the chrome extension: https://github.com/anyproto/anytype-ts/tree/main/extension and the gRPC https://github.com/anyproto/anytype-heart/blob/main/pb/service/service.pb.go

- local backup

Maybe `~/.config/anytype/data`? Not sure.

## Extensions

- https://github.com/anyproto/roadmap/issues/19

## Self-Hosted

See [self-hosting.md](./self-hosting.md).

## TODO

- `any-sync-filenode`

  - [ ] [Reduce s3 PUT/GET requests](https://github.com/anyproto/any-sync-filenode/issues/118)
  - [ ] [use fsstore instead of s3store](https://github.com/anyproto/any-sync-dockercompose/pull/78)
  - [ ] optional redis

- `any-sync-coordinator`

  > see `DRPCRegister` and `\*rpcHandler\) [A-Z]`

  - [ ] [loose coupling MongoDB](https://github.com/anyproto/any-sync-coordinator/issues/80)
  - [ ] ~~Use FerretDB+Sqlite https://github.com/FerretDB/FerretDB~~
    > not working, see:
    - https://github.com/FerretDB/FerretDB/blob/main/website/docs/reference/supported-commands.md
    - https://github.com/FerretDB/FerretDB/blob/main/website/docs/diff.md
  - [x] [replace mongo with https://github.com/256dpi/lungo](./patches/)

- `any-sync-consensusnode`

  - [x] remove mongo by implementing [fakeDB](./patches/)

- P2P

  - [ ] [show the P2P status](https://github.com/anyproto/anytype-heart/issues/1341)
  - [ ] [configure peers manually for non-mDNS tailscale](https://github.com/anyproto/anytype-heart/issues/1341)

- [ ] ~~[Limit users on a self hosted instance](https://github.com/orgs/anyproto/discussions/193)~~
