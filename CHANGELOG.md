# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
