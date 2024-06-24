# anytype-all

I want to migrate my notes and TODOs to Anytype for long-term usage. Before doing so, I need to make sure it is secure and reliable.

## development status

- https://community.anytype.io/t/development-pace-roadmap-for-2025/22101/10

## open source

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
- threat model

## Analytics & Tracking

- https://doc.anytype.io/anytype-docs/data-and-security/analytics-and-tracking
- https://github.com/orgs/anyproto/projects/1/views/1?pane=issue&itemId=29227689

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

## self-hosted

- https://tech.anytype.io/how-to/self-hosting
- https://github.com/orgs/anyproto/discussions/categories/self-hosting?discussions_q=category%3ASelf-hosting+
- https://github.com/orgs/anyproto/discussions/17
- https://github.com/anyproto/any-sync-dockercompose
- https://github.com/anyproto/ansible-anysync
- https://forge.puppetlabs.com/modules/anyproto/anysync/readme
- Limit users on a self hosted instance: https://github.com/orgs/anyproto/discussions/193
