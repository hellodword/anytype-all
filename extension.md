# extension & plug-in

- https://github.com/anyproto/roadmap/issues/19

## Runtime location

It definitely should be in the `anytype-heart`, exposing new APIs for clients and providing the ability for the same cross-platform experiences.

It only works when the client is running, not as a headless client for automation. Because the `anytype-heart` already provides this capability, see [this](./README.md#backup--restore).

## Why

I think [Extism](https://github.com/extism) looks great. It implements a [kernel](https://github.com/extism/extism/blob/main/kernel) in Rust and builds it to `kernel.wasm`, then loads the `kernel.wasm` in the Wasm runtime. It provides official Go SDK (non-CGO), JavaScript SDK, and Java SDK.

## Performance

Performance is not an issue for such GUI apps; see https://dylibso.com/blog/how-does-extism-work/

However, it might be an issue for iOS because there is no AOT mode allowed by default.

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
- Implement upgrade interval checks on the client side.

## Signing

> Similar to the methods used by Mozilla, Chrome, VSCode marketplace, Android APKs, or comparable platforms.

## Developer Mode

> The developer mode is inspired by Chromium's developer mode.

The developer mode will ignore the signing, allowing developers to load any extensions, including unpacked extensions.

Anytype clients should repeatedly display a prominent warning when users try to enable developer mode.

To limit the developer mode (or not?):

- Automatically disable or uninstall the extension after 3 restarts of Anytype.
- Automatically disable or uninstall the extension after 12 hours.

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

## Feedback & TestFlight

## Use cases

> https://obsidian.md/plugins

- Publish to a URL or website.
- Search pinyin.
- LLMs autocomplete.
- Image OCR to text.

## Platform restrictions

- iOS:

  - https://developer.apple.com/support/terms/apple-developer-program-license-agreement/#b331

  - https://extism.org/docs/questions/#can-i-use-extism-with-my-own-webassembly-runtime

  - https://developer.apple.com/documentation/apple-silicon/porting-just-in-time-compilers-to-apple-silicon
  - https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_cs_allow-jit

  - https://github.com/tetratelabs/wazero/blob/main/README.md#runtime
  - https://pkg.go.dev/github.com/extism/go-sdk#PluginConfig

  - https://github.com/wasmerio/wasmer/issues/4343#issuecomment-1877472566
  - https://github.com/oliveeyay/SwiftWasmer

  - https://github.com/extism/wamr-sdk
  - https://github.com/bytecodealliance/wasm-micro-runtime/issues/242
  - https://github.com/bytecodealliance/wasm-micro-runtime/wiki/Performance
  - https://github.com/bytecodealliance/wasm-micro-runtime/blob/main/product-mini/platforms/ios/generate_xcodeproj.sh
  - https://github.com/bytecodealliance/wasm-micro-runtime/blob/main/doc/embed_wamr.md

  - https://github.com/wasm3/wasm3/blob/main/README.md#motivation
  - https://shareup.app/blog/using-webassembly-on-ios/
  - https://github.com/matiasinsaurralde/go-wasm3/pull/6

  - https://github.com/swiftwasm/WasmKit

- Android:
- macOS:
- Windows:
- AppImage:

---

## Ref

- https://dylibso.com/blog/how-does-extism-work/
- https://dylibso.com/blog/plug-in-system-in-hiding/
- https://github.com/MAIF/wasmo
- https://github.com/obsidianmd/obsidian-help/blob/ce06db8fd3ae0f90e6e5c56d4a8f82d8ab37f0a8/en/Extending%20Obsidian/Plugin%20security.md#plugin-capabilities
- https://github.com/extism/extism/discussions/684
- https://github.com/1Password/onepassword-sdk-go
