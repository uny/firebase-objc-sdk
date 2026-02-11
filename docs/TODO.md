# Low-Priority Wrapper Tasks

The following FirebaseAILogic types are not yet wrapped and are deferred for future work.

## Unwrapped Types

- **`LiveAudioTranscription`** - Live audio transcription wrapper for `inputAudioTranscription` / `outputAudioTranscription` on `LiveServerContent`.
- **`ImagenImagesBlockedError`** - Error type for Imagen image generation when images are blocked.
- **`LiveSessionUnsupportedMessageError`** - Error thrown when an unsupported message type is received in a live session.
- **`LiveSessionError`** - General live session error types.

## Internal / Deferred APIs

- **`GenerationConfig.responseJSONSchema`** - Internal API for raw JSON schema; prefer `responseSchema` (wrapped via `Schema`).
