# extension & plug-in

- https://github.com/anyproto/roadmap/issues/19

## What I am concerned about

- Feature:

  It only works when the client is running, not as a headless client for automation. Because the `anytype-heart` already provides this capability, see [this](./README.md#backup--restore).

- Security & Sandbox:

  I think [extism](https://github.com/extism) looks great. It implements a [kernel](https://github.com/extism/extism/blob/main/kernel) in Rust and builds it to `kernel.wasm`, then loads the `kernel.wasm` in the Wasm runtime. It provides official Go SDK (non-CGO), JavaScript SDK, and Java SDK.

- Languages:

  All languages that support compilation to Wasm are acceptable.

- Interpreter & Editor:

  I'm not sure. But check [this](https://extism.org/blog/sandboxing-llm-generated-code/), it prepares an `eval` plug-in, and eval the input Javascript.

- Runtime location:

  It definitely should be in the `anytype-heart`, exposing new APIs for clients and providing the ability for the same cross-platform experiences.

---

- https://dylibso.com/blog/how-does-extism-work/
- https://dylibso.com/blog/plug-in-system-in-hiding/
- https://github.com/MAIF/wasmo
