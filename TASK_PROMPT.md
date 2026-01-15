### 2. 実装指示書 (プロンプト)
ファイル名: `TASK_PROMPT.md`

これは実際に作業を依頼する際にAIに貼り付ける、または読み込ませる内容です。

```markdown
# Task: Implement FirebaseAILogic Wrapper

Please implement the Objective-C wrapper classes for the **FirebaseAILogic** library referencing the rules defined in `AGENTS.md`.

## Target Documentation
Reference: [FirebaseAILogic API Reference](https://firebase.google.com/docs/reference/swift/firebaseailogic/api/reference/Classes)
(Note: Since you cannot browse the live web, please infer the public API surface based on standard Vertex AI in Firebase patterns or request specific file contents if needed, but primarily follow the provided pattern.)

## Scope
Please implement wrappers for the following key classes/structs found in `FirebaseAILogic`. I need `Sources/FirebaseAI/Sources/*.swift` files generated.

1. **GenerativeModel** (Key class)
   - Initializers (refer to `Backend` integration)
   - `generateContent` methods (streaming and unary)
   - `countTokens` methods
2. **GenerateContentResponse**
   - Wrapper for the response object.
3. **GenerateContentStreamResponse** (if applicable/different)
4. **Candidate**
5. **Part** (TextPart, InlineDataPart, etc. - this might need careful handling if it's an Enum in Swift)
6. **Content**
7. **GenerationConfig**
8. **SafetySetting**

## Specific Instructions for this Batch
- Verify `Package.swift` targets are correct (already provided in context).
- Ensure strictly **NO default arguments** are implemented in Swift functions.
- Use `@objc(KFB...)` prefix for all classes.
- Ensure all public properties of the response objects (like `candidates` in `GenerateContentResponse`) are exposed via the wrapper.

## Current Progress
- `FirebaseAI.swift` is done.
- `Backend.swift` is done.

Please start by implementing **`GenerativeModel.swift`** and **`GenerateContentResponse.swift`**.
