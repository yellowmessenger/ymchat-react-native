import { NativeModules, NativeEventEmitter, TurboModuleRegistry } from 'react-native';

// On iOS New Architecture, RCT_EXPORT_MODULE registers the native module under
// 'YMChatReactNative' (the ObjC class name) to avoid a collision: the fallback
// NSClassFromString lookup in RCTTurboModuleManager finds the underlying
// YMChat iOS SDK singleton class first when the name is 'YMChat', causing the
// TurboModule conformance check to fail. On Android and old-arch iOS the module
// is still registered as 'YMChat'.
const YMChat =
  (TurboModuleRegistry != null && TurboModuleRegistry.get != null
    ? (TurboModuleRegistry.get('YMChatReactNative') ?? TurboModuleRegistry.get('YMChat'))
    : null) ?? NativeModules.YMChat;

// NativeEventEmitter requires a non-null module in RN 0.76+.
// Guard against null so the JS module doesn't crash when the module hasn't
// loaded yet (e.g. during hot reload or if the binary is stale).
const YMChatEvents = YMChat != null ? new NativeEventEmitter(YMChat) : null;

module.exports = { YMChat, YMChatEvents };
