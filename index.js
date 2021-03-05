
import { NativeModules, NativeEventEmitter } from 'react-native';

const { YMChat } = NativeModules;
const YMChatEvents = new NativeEventEmitter(YMChat);

module.exports = { "YMChat": YMChat, "YMChatEvents": YMChatEvents };
