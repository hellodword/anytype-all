# self-hosting

[The official dockercompose](https://github.com/anyproto/any-sync-dockercompose) is good, but a bit too heavy for me, and the scripts are complicated:

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

By applying some modifications and workarounds, I can run a self-hosted instance without Minio and MongoDB, using only one sync node:

```
$ docker compose stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}'
NAME                                   CPU %     MEM USAGE / LIMIT
anytype-all-any-sync-node-1-1          0.00%     13.29MiB / 128MiB
anytype-all-any-sync-filenode-1        0.00%     12.88MiB / 128MiB
anytype-all-any-sync-consensusnode-1   0.00%     8.09MiB / 128MiB
anytype-all-redis-1                    0.16%     3.934MiB / 128MiB
anytype-all-any-sync-coordinator-1     0.00%     9.477MiB / 128MiB
```

This is the directory size within a new space:

```
$ du --max-depth=1 -h ./storage
20K	./storage/any-sync-coordinator
1.1M	./storage/redis
12K	./storage/any-sync-consensusnode
2.0M	./storage/any-sync-filenode
716K	./storage/any-sync-node-1
3.7M	./storage
```

## Explanation

It's highly personalized, **use at your own risk**.

1. Replace `s3Store` with `fileDevStore` for `any-sync-filenode`. Due to the design, I think it won't cause race conditions for personal use.
2. Replace `MongoDB` with a `fakeDB` based on JSON files for `any-sync-consensusnode`. It handles few requests for personal use, so I think it's acceptable.
3. Replace `mongo` with `github.com/256dpi/lungo` for `any-sync-coordinator`. I'm not sure about this, but it works.
4. Do not rely on the P2P feature because Tailscale does not support mDNS, although there is [a feature request](https://github.com/anyproto/anytype-heart/issues/1341) for it.

## What's the next

- [ ] Hardening the containers (distroless, non-root, CVE-less)
- [ ] Remove redis
- [ ] Combine all nodes (filenode, sync node, coordinator, consensusnode) to one node, publish a single port

## Usage

1. Initialize the `.env` file:

```sh
cp .env.template .env
```

2. Install `github.com/anyproto/any-sync-tools/anyconf@latest`:

You can install it in any way you prefer. I use Docker and an alias:

```sh
docker build -t anyconf:latest -f ./docker/anyconf.Dockerfile .
alias anyconf='docker run --rm --network none --env-file .env --user "$(id -u):$(id -g)" -v "$(pwd)":/app -w /app anyconf:latest'
```

3. Generate nodes and accounts:

```sh
source .env

anyconf create-network --account account-coordinator.yml --output nodes.yml --address $ANY_SYNC_COORDINATOR_HOST:$ANY_SYNC_COORDINATOR_PORT
anyconf add-node --t consensus --n nodes.yml --account account-consensusnode.yml --address $ANY_SYNC_CONSENSUSNODE_HOST:$ANY_SYNC_CONSENSUSNODE_PORT
anyconf add-node --t file --n nodes.yml --account account-filenode.yml --address $ANY_SYNC_FILENODE_HOST:$ANY_SYNC_FILENODE_PORT
anyconf add-node --t tree --n nodes.yml --account account-node-1.yml --address $ANY_SYNC_NODE_1_HOST:$ANY_SYNC_NODE_1_PORT
```

4. Edit `.env` again with the generated `account-*.yml` and `nodes.yml` files:

- The environment variables ending with `_PEER_ID`, `_PEER_KEY`, or `_SIGNING_KEY` are extracted from the account-\*.yml files.
- The `ANY_SYNC_NETWORK_ID` and `ANY_SYNC_NETWORK_NETWORK_ID` correspond to the `id` and `networkId` in the `nodes.yml` file.
- The `ANY_EXTERNAL_HOST` is the host you want to use to access the instance. Examples include: `127.0.0.1`, `192.168.10.101`, or `home.foo.ts.net`.

5. Generate config files:

```sh
cp configs/any-sync-coordinator.yml.template configs/any-sync-coordinator.yml
./scripts/apply-env.sh configs/any-sync-coordinator.yml

cp configs/any-sync-consensusnode.yml.template configs/any-sync-consensusnode.yml
./scripts/apply-env.sh configs/any-sync-consensusnode.yml

cp configs/any-sync-filenode.yml.template configs/any-sync-filenode.yml
./scripts/apply-env.sh configs/any-sync-filenode.yml

cp configs/any-sync-node-1.yml.template configs/any-sync-node-1.yml
./scripts/apply-env.sh configs/any-sync-node-1.yml

cp configs/client.yml.template configs/client.yml
./scripts/apply-env.sh configs/client.yml
```

6. Start the Docker Compose setup:

```sh
docker compose up --build --remove-orphans -d
```

7. Use the generated `client.yml` with clients:

For more details, see [the documentation](https://doc.anytype.io/anytype-docs/data-and-security/self-hosting/self-hosted).

## Ref

- https://tech.anytype.io/how-to/self-hosting
- https://github.com/orgs/anyproto/discussions/categories/self-hosting?discussions_q=category%3ASelf-hosting+
- https://github.com/orgs/anyproto/discussions/17
- https://github.com/anyproto/any-sync-dockercompose
- https://github.com/anyproto/ansible-anysync
- https://forge.puppetlabs.com/modules/anyproto/anysync/readme

---

[^1]: [Reduce s3 PUT/GET requests](https://github.com/anyproto/any-sync-filenode/issues/118)
