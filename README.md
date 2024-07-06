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

For such an app, the security of both the protocols and the clients is a concern. I'm not an expert and can't determine if the protocols are secure. But there are too many dependencies in the clients, and I don't think they have been well-audited.

However, in the meantime:

1. I use it with a VPN, so the security of the protocols is not a big deal for me.
2. I use the iOS client, while iOS has many built-in security policies.
3. I use Firejail to run the AnyType on Linux.

## Analytics & Tracking

It's possible to disable analytics and tracking through firewall rules or patches, and an option to disable them will be available.

- https://doc.anytype.io/anytype-docs/data-and-security/analytics-and-tracking
- https://github.com/orgs/anyproto/projects/1/views/1?pane=issue&itemId=29227689
- firewall
  - https://github.com/orgs/anyproto/discussions/206
  - https://github.com/anyproto/anytype-heart/blob/6f52f45a6a4caaad384080f291f43276c39cec4e/core/anytype/config/nodes/production.yml

## Backup & Restore

See [backup.md](./backup.md).

## Self-Hosted

See [self-hosting.md](./self-hosting.md).

## Extensions

- https://github.com/anyproto/roadmap/issues/19

## TODO

- [ ] [(any-sync-filenode) Reduce s3 PUT/GET requests](https://github.com/anyproto/any-sync-filenode/issues/118)
- [ ] (any-sync-filenode) optional redis
- [ ] [(any-sync-coordinator) loose coupling MongoDB](https://github.com/anyproto/any-sync-coordinator/issues/80)
- [x] [(any-sync-coordinator) replace mongo with https://github.com/256dpi/lungo](./patches/)
- [x] (any-sync-consensusnode) remove mongo by implementing [fakeDB](./patches/)
- [ ] [show the P2P status](https://github.com/anyproto/anytype-heart/issues/1341)
- [ ] [configure peers manually for non-mDNS tailscale](https://github.com/anyproto/anytype-heart/issues/1341)
- [ ] ~~[Limit users on a self hosted instance](https://github.com/orgs/anyproto/discussions/193)~~
