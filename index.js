import { NativeModules, NativeEventEmitter, TurboModuleRegistry } from 'react-native';

// Use TurboModuleRegistry on New Architecture; fall back to NativeModules on Old Architecture.
const YMChat =
  TurboModuleRegistry != null && TurboModuleRegistry.get != null
    ? TurboModuleRegistry.get('YMChat')
    : NativeModules.YMChat;

// Single unified event emitter — works on both architectures.
// The native YMChat module exposes addListener/removeListeners directly,
// so no separate YMEventEmitter module is needed.
const YMChatEvents = new NativeEventEmitter(YMChat);

module.exports = { YMChat, YMChatEvents };
