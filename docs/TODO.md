# Low-Priority Wrapper Tasks

The following FirebaseAILogic types are not yet wrapped and are deferred for future work.

## Internal / Deferred APIs

- **`GenerationConfig.responseJSONSchema`** - Internal API for raw JSON schema; prefer `responseSchema` (wrapped via `Schema`).

## Gap Analysis (vs SDK v12.12.0)

Most public types in `FirebaseAILogic` are fully covered by the ObjC wrapper.
Below is the list of remaining gaps and their status.

### v12.12.0 changes

- **Imagen deprecation** — All Imagen wrapper types and the `imagenModel(...)` /
  `templateImagenModel()` factories on `FirebaseAI` now carry `@available(*, deprecated, ...)`
  to mirror the upstream deprecation. Imagen models will shut down as early as June 2026; users
  should migrate to Gemini Image models ("Nano Banana").
- **Automatic function calling in `GenerativeModelSession`** — Upstream added support via the
  `FoundationModels.Tool` protocol. This is Swift-only (Foundation Models macros / Swift
  protocols) and is not exposed through the ObjC wrapper, consistent with the existing
  treatment of `Generable` / structured-output APIs. Manual function calling via
  `KFBFunctionDeclaration` + `KFBTool` remains the supported path for KMP consumers.
- **`GenerativeModelSession.GenerationError` `@nonexhaustive`** — The wrapper does not expose
  this Swift error enum directly (errors are bridged via `NSError`), so no wrapper change is
  required.
- **Compiler guard** — Updated `#if compiler(>=6.2)` to `#if compiler(>=6.2.3)` in
  `GenerativeModelSession.swift` and `FirebaseAI.swift` to match the upstream guard.
- **Lower minimum deployment targets (upstream)** — Upstream FirebaseAILogic lowered its
  minimum macOS / watchOS deployment targets and removed the per-class
  `@available(iOS 15.0, macOS 12.0, ..., watchOS 8.0, *)` annotations from many public types.
  The wrapper still applies these annotations because its other wrapper types (e.g.
  `RequestOptions`) continue to be annotated as iOS 15+ / macOS 12+. Lowering the wrapper-wide
  minimums is left as a follow-on cleanup; functionality is unaffected for KMP consumers.

### Addressed

- ~~**`CountTokensResponse.promptTokensDetails`**~~ — Added.
- ~~**`CodeExecution`**~~ — Already wrapped via `Tool.codeExecution()`. The upstream `CodeExecution` struct is an empty marker type with no properties; a dedicated wrapper is unnecessary.
- ~~**`ExecutableCodePart.Language`**~~ — `.python` is the only public case in the upstream SDK and is already exposed via `ExecutableCodeLanguage.python`.
- ~~**`Schema.StringFormat`**~~ — The upstream SDK has no predefined cases (only `.custom(_:)`). The current raw `String` approach in `Schema.string(format:)` is the correct design.
- ~~**`Schema.IntegerFormat`**~~ — `.int32` and `.int64` are the only predefined cases. The current `Schema.integer(format:)` already handles these via string matching (`"int32"` / `"int64"` / custom).
- ~~**`GenerationConfig` read properties**~~ — Added stored copies so all init parameters are readable via ObjC properties.
- ~~**`LiveServerContent.groundingMetadata`**~~ — Added.
- ~~**`LiveGenerationConfig` read properties**~~ — Added stored copies so all init parameters are readable via ObjC properties.
- ~~**`ThinkingConfig` read properties**~~ — Added stored copies so all init parameters are readable via ObjC properties.
- ~~**`JSONValue` / `JSONObject` → `[String: Any]` conversion & public init**~~ — Added `convertToJSONObject` / `convertToJSONValue` helpers and public convenience inits on `FunctionResponsePart` and `FunctionCallPart`.

### Deferred (SDK-side limitations)

- **`ImagenGCSImage`** — Not public in the SDK; blocked upstream.
- **`ImagenModel.generateImages(gcsURI:)`** — Not public in the SDK; blocked upstream.
- **`GenerationConfig` upstream property access** — All stored properties of `FirebaseAILogic.GenerationConfig` are `internal` (not `public`), so the ObjC wrapper stores its own copies passed at init time. If the upstream SDK makes these properties public in a future version, the wrapper can be simplified to delegate directly.

### Not Applicable

- **`PartsRepresentable`** — Swift-only protocol; ObjC wrappers provide dedicated convenience methods instead.
- **`TemplateChatSession`** — Marked `internal` in the SDK; not exposed.
- ~~**`GenerativeModelSession`**~~ — Wrapped. Text-based `respond` and `streamResponse` are exposed. Structured output (`Generable`/`FoundationModels`) methods are Swift-only and not applicable for ObjC wrapping.
