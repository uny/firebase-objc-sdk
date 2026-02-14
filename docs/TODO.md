# Low-Priority Wrapper Tasks

The following FirebaseAILogic types are not yet wrapped and are deferred for future work.

## Internal / Deferred APIs

- **`GenerationConfig.responseJSONSchema`** - Internal API for raw JSON schema; prefer `responseSchema` (wrapped via `Schema`).

## Gap Analysis (vs SDK v12.9.0)

Most public types in `FirebaseAILogic` are fully covered by the ObjC wrapper.
Below is the list of remaining gaps and their status.

### Addressed

- ~~**`CountTokensResponse.promptTokensDetails`**~~ — Added.

### Pending (design work needed)

- **`JSONValue` / `JSONObject`** — Used in `FunctionCallPart.args` and `FunctionResponsePart.response`. Requires ObjC-friendly design (e.g. `NSDictionary` bridge).
- **`CodeExecution`** — `Tool.codeExecution()` wrapper not yet exposed.
- **`ExecutableCodePart.Language`** — Currently represented as a raw `String`; could provide ObjC constants.
- **`Schema.StringFormat` / `Schema.IntegerFormat`** — Currently represented as raw `String`; could provide ObjC constants.

### Deferred (SDK-side limitations)

- **`ImagenGCSImage`** — Not public in the SDK; blocked upstream.
- **`ImagenModel.generateImages(gcsURI:)`** — Not public in the SDK; blocked upstream.

### Not Applicable

- **`PartsRepresentable`** — Swift-only protocol; ObjC wrappers provide dedicated convenience methods instead.
- **`TemplateChatSession`** — Marked `internal` in the SDK; not exposed.
