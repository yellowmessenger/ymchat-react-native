# YMChat Example App — Setup Guide

This example app tests the `ymchat-react-native` SDK with **New Architecture enabled** on both Android and iOS.

---

## Prerequisites

- Node 18+
- Ruby 3.1+ (for CocoaPods)
- Xcode 15+ (iOS)
- Android Studio / JDK 17+ (Android)
- CocoaPods: `sudo gem install cocoapods`

---

## One-time setup

```bash
# 1. Install JS dependencies
cd example
npm install

# 2. iOS — generate the Xcode project and install pods
#    (react-native init generates the .xcodeproj; pod install wires up all native deps)
cd ios
pod install
cd ..
```

### Android — generate the debug keystore (one-time)

```bash
cd android/app
keytool -genkey -v \
  -keystore debug.keystore \
  -storepass android \
  -alias androiddebugkey \
  -keypass android \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -dname "CN=Android Debug,O=Android,C=US"
cd ../..
```

---

## Running the app

### iOS (New Architecture enabled by default in RN 0.76)

```bash
# From the example/ directory:
npm run ios
# or target a specific simulator:
npx react-native run-ios --simulator "iPhone 15 Pro"
```

### Android (New Architecture via gradle.properties)

```bash
npm run android
```

`android/gradle.properties` already has `newArchEnabled=true`. To test **Old Architecture**:
```
newArchEnabled=false
```

---

## What to test

Open the app — the badge in the top-right corner confirms the active architecture:

| Badge | Meaning |
|---|---|
| ✓ New Architecture | `TurboModuleRegistry.get('YMChat')` returned the module |
| ⚠ Old Architecture | Fell back to `NativeModules.YMChat` |

### Test checklist

1. **Enter your Bot ID** in the Config section and tap **setBotId**
2. Tap **Full configure + startChatbot** — bot should open
3. Verify **YMBotCloseEvent** fires when you close the bot
4. Tap **reloadBot** while bot is open
5. Tap **sendEventToBot** — watch for **YMChatEvent** in the log
6. Tap **registerDevice → Promise** — should resolve or reject with a clear error
7. Tap **getUnreadMessagesCount → Promise** — should resolve with a count string
8. Tap **Speech config** — re-open bot and verify mic FAB appears
9. Tap **Purple theme** — re-open bot and verify theme is applied
10. Switch `newArchEnabled=false` on Android / `RCT_NEW_ARCH_ENABLED=0` on iOS,
    rebuild, and repeat the above — should work identically under Old Architecture

---

## iOS — Testing with New Architecture explicitly enabled

```bash
RCT_NEW_ARCH_ENABLED=1 pod install
npx react-native run-ios
```

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `YMChat is null` on startup | Run `npm install` and rebuild. Check Metro is watching the parent SDK directory. |
| iOS pod install fails | `cd ios && pod repo update && pod install` |
| Android build fails with `NativeYMChatSpec not found` | Run `./gradlew generateCodegenArtifactsFromSchema` in `android/` |
| Events not firing | Check that `YMChatEvents.addListener(...)` is called before `startChatbot()` |
| Bot ID assertion crash | Call `setBotId(...)` before any config setter or `startChatbot()` |
