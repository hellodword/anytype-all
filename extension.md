# extension & plug-in

- https://github.com/anyproto/roadmap/issues/19

## What I am concerned about

- Runtime location

  It definitely should be in the `anytype-heart`, exposing new APIs for clients and providing the ability for the same cross-platform experiences.

  It only works when the client is running, not as a headless client for automation. Because the `anytype-heart` already provides this capability, see [this](./README.md#backup--restore).

- Why

  I think [Extism](https://github.com/extism) looks great. It implements a [kernel](https://github.com/extism/extism/blob/main/kernel) in Rust and builds it to `kernel.wasm`, then loads the `kernel.wasm` in the Wasm runtime. It provides official Go SDK (non-CGO), JavaScript SDK, and Java SDK.

- Manifest & Policy

  > Inspired by the [Chromium extension manifest](https://developer.chrome.com/docs/extensions/reference/manifest) and [AWS permissions boundaries](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html).

  1. Limited memory usage. Provided by Extism.
  2. Limited scope: space/set/object.
  3. Jailed networking (host, IP, port, total size and speed of read and write, time limit).
  4. Filesystem access controls. Provided by Extism.
  5. Group the gRPC ClientCommands.
  6. Limit the content size of gRPC requests.
  7. Pure text or complex content (consider this as potentially more vulnerable).
  8. Storage for each extension.
  9. Listening API.
  10. GUI widgets.

- Safe mode

  > Inspired by Windows Safe Mode.

  Desktop apps can implement this easily. iOS can use the context menu. Android can use app shortcuts. These could serve as entry points for Anytype's safe mode. If one of the extensions is buggy or vulnerable (e.g., consuming all CPU resources and preventing uninstallation), we need a mechanism to start the application with all extensions disabled.

- Upgrading

- Developer Mode

- Audited extensions

  - Open-sourced.
  - Reproducible.
  - No obfuscated code, [self-documenting](https://en.wikipedia.org/wiki/Self-documenting_code).
  - Principle of least privilege.
  - E2E testing.

- Supported languages

  All languages that support compilation to Wasm are acceptable.

- Interpreter & Editor

  I'm not sure. But check [this](https://extism.org/blog/sandboxing-llm-generated-code/), it prepares an `eval` plug-in and evaluates the input JavaScript.
  
  In the other side, is this really necessary? Consider Obsidian, which has a successful extension ecosystem and only supports developing extensions with `Node.js`.

- Use cases

  > https://obsidian.md/plugins

  - Publish to a URL or website.
  - Search pinyin.
  - LLMs autocomplete.
  - Image OCR to text.

---

- https://dylibso.com/blog/how-does-extism-work/
- https://dylibso.com/blog/plug-in-system-in-hiding/
- https://github.com/MAIF/wasmo
- https://github.com/obsidianmd/obsidian-help/blob/ce06db8fd3ae0f90e6e5c56d4a8f82d8ab37f0a8/en/Extending%20Obsidian/Plugin%20security.md#plugin-capabilities
- https://github.com/extism/extism/discussions/684
- https://github.com/1Password/onepassword-sdk-go
