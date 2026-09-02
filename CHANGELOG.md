# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.5.2]

### Fixed

- Upgraded native Android SDK to pick up a text-to-speech fallback for the widget's Read aloud button — Android `YMChatbot-Android` 3.5.1. `android.webkit.WebView` doesn't implement `window.speechSynthesis`, so the button previously did nothing there; it now falls back to a native `TextToSpeech` bridge. No JS/bridge API changes.

## [3.5.1]

### Fixed

- Upgraded native iOS SDK to pick up a WebView keyboard-resize fix — iOS `YMChat` 2.4.1. The embedded WKWebView now resizes when the on-screen keyboard opens, keeping input fields visible instead of being covered. No JS/bridge API changes.

## [3.5.0]

### Added

- **Auto-Sent Initial User Message** — lets the host app automatically send a configured message as soon as the chat widget opens, rendered as a real outgoing user message, via `YMChat.setInitialUserMessage('...')`. Bridges the native SDKs' `initialUserMessage` config to JS for the first time (`YMChatbot-Android` since v3.5.0, iOS `YMChat` since 2.4.0 — this package now requires those versions or newer).

## [3.4.0]

### Added

- **Configurable Upload Sources** (Android only) — restricts the attachment picker to specific sources via `YMChat.setAllowedUploadSources(['camera'])` (or `['file']`, or both). Bridges the native Android SDK's `allowedUploadSources` config to JS for the first time (`YMChatbot-Android` since v3.3.0, already pinned by this package). No iOS equivalent exists natively, so calling this on iOS throws — the native module doesn't implement the selector.

## [3.3.0]

### Added

- **`stopVoiceMode()`** — lets the host app programmatically end an active voice call, e.g. when a modal presentation covers the chatbot and the native view-lifecycle callback that would normally stop voice mode doesn't fire. Bridges the native SDKs' `stopVoiceMode()` to JS for the first time (iOS `YMChat` since 2.2.0, Android `YMChatbot-Android` since v3.2.0 — both already pinned by this package).

## [3.2.0]

### Added

- **Activation Mode** — lets the host app open the widget directly into voice mode instead of chat, via `YMChat.setActivationMode('voice')` (or `'chat'`, the default). Bridges the native SDKs' `activationMode` config to JS for the first time (iOS `YMChat` since 2.1.0, Android `YMChatbot-Android` since v3.1.0 — both already pinned by this package).

## [3.1.0]

### Added

- Upgraded native SDKs to pick up automatic screen-awake handling during Voice Mode — Android YMChatbot-Android v3.4.0, iOS YMChat 2.3.0. The screen now stays on for the duration of an active voice conversation and returns to normal on call end; entirely internal to the native SDKs, no JS/bridge API changes.

## [3.0.3]

### Security

- Upgraded native Android SDK to YMChatbot-Android v3.3.2, closing a residual WebView popup (`window.open()`) URL-scheme gap left over from the v3.3.1 fix. No JS/bridge API changes. iOS dependency unchanged.

## [3.0.2]

### Security

- Upgraded native SDKs to pick up a WebView URL-handling fix — Android YMChatbot-Android v3.3.1, iOS YMChat 2.2.1. No JS/bridge API changes.

## [3.0.1]

### Fixed

- Added a `files` whitelist to `package.json` so the published npm package ships only the SDK source, excluding the example app and Android build artifacts.

## [3.0.0]

### Added

- React Native New Architecture (TurboModule) support.
- Example app for testing the New Architecture.

### Changed

- **BREAKING:** Migrated the YMChat module to codegen and updated dependencies.
- iOS: use the TurboModule name and dispatch UI calls on the main thread.
- Example iOS: CocoaPods, scheme, and App fixes.

## [2.22.0]

- Upgrade to compile/target SDK 35.

## [2.21.2]

- Bug fix: `setVersion` argument type was unsupported in newer React Native versions (#106).

## [2.21.1]

- Maintenance release.

## [2.21.0]

- Enhancement: emit error event on bot load failure (#101).
