# extension & plug-in

- https://github.com/anyproto/roadmap/issues/19

## Runtime location

It definitely should be in the `anytype-heart`, exposing new APIs for clients and providing the ability for the same cross-platform experiences.

It only works when the client is running, not as a headless client for automation. Because the `anytype-heart` already provides this capability, see [this](./README.md#backup--restore).

## Why

I think [Extism](https://github.com/extism) looks great. It implements a [kernel](https://github.com/extism/extism/blob/main/kernel) in Rust and builds it to `kernel.wasm`, then loads the `kernel.wasm` in the Wasm runtime. It provides official Go SDK (non-CGO), JavaScript SDK, and Java SDK.

## Performance

Not an issue for such GUI apps, see https://dylibso.com/blog/how-does-extism-work/

## Manifest & Policy

> Inspired by the [Chromium extension manifest](https://developer.chrome.com/docs/extensions/reference/manifest), [Android Manifest](https://developer.android.com/guide/topics/manifest/manifest-intro) and [AWS permissions boundaries](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html).

- Plugins should never read the key.
- Limited memory usage. Provided by Extism.
- Limited scope: space/set/object.
- Jailed networking (host, IP, port, total size and speed of read and write, time limit).
- Filesystem access controls. Provided by Extism.
- Group the gRPC ClientCommands (Per command or per group, see systemd-analyze syscall-filter).
- Limit the content size of gRPC requests.
- Pure text or complex content (consider this as potentially more vulnerable).
- Storage for each extension.
- Listening API.
- GUI widgets.
- Dynamically approve or reject some permissions at runtime.
- Clipboard.
- Customize domains for different providers' endpoints, for example: plugins based on LLM services.
- Minimal anytype-heart version.
- Target platforms.

## Safe mode

> Inspired by Windows Safe Mode and [`--disable-extensions`](https://peter.sh/experiments/chromium-command-line-switches/#disable-extensions) in Chromium.

If one of the extensions is buggy or vulnerable (e.g., consuming all CPU resources and preventing uninstallation), we need a mechanism to start the application with all extensions disabled.

Desktop apps can implement this easily. iOS can use the context menu. Android can use app shortcuts. These could serve as entry points for Anytype's safe mode.

## Installing & Distributing & Upgrading

- Users can add official or third-party repositories via URLs, and can easily remove them, similar to how it's done with [winget source](https://github.com/microsoft/winget-cli/blob/master/doc/windows/package-manager/winget/source.md), [scoop bucket](https://github.com/ScoopInstaller/Scoop/wiki/Buckets), or equivalent tools.
- Implement signing, similar to the methods used by Mozilla, Chrome, VSCode marketplace, Android APKs, or comparable platforms.
- Implement upgrade interval checks on the client side.

## Developer Mode

## Testing

- https://extism.org/docs/concepts/testing/

## Communicate with external APPs

Extend the `AccountLocalLinkNewChallenge`?

## Audited extensions

- Open-sourced.
- Reproducible.
- No obfuscated code, [self-documenting](https://en.wikipedia.org/wiki/Self-documenting_code).
- Principle of least privilege.
- [Formal verification](https://dylibso.com/blog/formally-verified-webassembly-plugins/).

## Supported languages

All languages that support compilation to Wasm are acceptable.

## Interpreter & Editor

I'm not sure. But check [this](https://extism.org/blog/sandboxing-llm-generated-code/), it prepares an `eval` plug-in and evaluates the input JavaScript.

In the other side, is this really necessary? Consider Obsidian, which has a successful extension ecosystem and only supports developing extensions with `Node.js`.

## Use cases

> https://obsidian.md/plugins

- Publish to a URL or website.
- Search pinyin.
- LLMs autocomplete.
- Image OCR to text.

---

## Ref

- https://dylibso.com/blog/how-does-extism-work/
- https://dylibso.com/blog/plug-in-system-in-hiding/
- https://github.com/MAIF/wasmo
- https://github.com/obsidianmd/obsidian-help/blob/ce06db8fd3ae0f90e6e5c56d4a8f82d8ab37f0a8/en/Extending%20Obsidian/Plugin%20security.md#plugin-capabilities
- https://github.com/extism/extism/discussions/684
- https://github.com/1Password/onepassword-sdk-go
