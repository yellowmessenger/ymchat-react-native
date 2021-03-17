import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const { YMChat, YMEventEmitter } = NativeModules;

var YMChatEvents
if (Platform.OS === "ios") {
    YMChatEvents = new NativeEventEmitter(YMEventEmitter);
} else {
    YMChatEvents = new NativeEventEmitter(YMChat);
}

module.exports = { "YMChat": YMChat, "YMChatEvents": YMChatEvents };
