# /// script
# requires-python = ">=3.10"
# dependencies = [
#     "pyyaml",
# ]
# ///
import yaml

with open(".env", "r") as envf:
    lines = envf.readlines()
    env_file_content = ''.join(lines)

    list_suffix_files = ["consensusnode", "filenode", "coordinator", "node-1"]
    for suffix in list_suffix_files:
        suffix_upper = suffix.replace('-', '_').upper()
        with open(f"account-{suffix}.yml") as acnf:
            yaml_content = yaml.safe_load(acnf)
            PEER_ID = yaml_content["account"]["peerId"]
            PEER_KEY = yaml_content["account"]["peerKey"]
            PEER_SIGNING_KEY = yaml_content["account"]["signingKey"]
            env_file_content = env_file_content.replace(f'ANY_SYNC_{suffix_upper}_PEER_ID=""', f'ANY_SYNC_{suffix_upper}_PEER_ID="{PEER_ID}"')
            env_file_content = env_file_content.replace(f'ANY_SYNC_{suffix_upper}_PEER_KEY=""', f'ANY_SYNC_{suffix_upper}_PEER_KEY="{PEER_KEY}"')
            env_file_content = env_file_content.replace(f'ANY_SYNC_{suffix_upper}_SIGNING_KEY=""', f'ANY_SYNC_{suffix_upper}_SIGNING_KEY="{PEER_SIGNING_KEY}"')
    with open(f"nodes.yml") as acnf:
        yaml_content = yaml.safe_load(acnf)

        env_file_content = env_file_content.replace('ANY_SYNC_NETWORK_ID=""', f'ANY_SYNC_NETWORK_ID="{yaml_content["id"]}"')
        env_file_content = env_file_content.replace('ANY_SYNC_NETWORK_NETWORK_ID=""', f'ANY_SYNC_NETWORK_NETWORK_ID="{yaml_content["networkId"]}"')
    with open(".env", "w") as envfw:
        envfw.write(env_file_content)
