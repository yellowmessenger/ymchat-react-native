import type {TurboModule} from 'react-native';
import {TurboModuleRegistry} from 'react-native';

export interface Spec extends TurboModule {
  // Bot configuration
  setBotId(botId: string): void;
  setAuthenticationToken(token: string): void;
  setDeviceToken(token: string): void;
  setCustomURL(url: string): void;
  setPayload(payload: Object): void;
  addKeyToPayload(key: string, value: string): void;
  setVersion(version: number): void;
  setCustomLoaderURL(url: string): void;

  // UI configuration
  showCloseButton(show: boolean): void;
  setStatusBarColor(color: string): void;
  setCloseButtonColor(color: string): void;
  setDisableActionsOnLoad(shouldDisableActionsOnLoad: boolean): void;
  setOpenLinkExternally(shouldOpenLinkExternally: boolean): void;

  // Speech configuration
  setEnableSpeech(speech: boolean): void;
  setMicButtonMovable(shouldMicButtonMovable: boolean): void;
  setMicIconColor(color: string): void;
  setMicBackgroundColor(color: string): void;

  // Feature flags
  useLiteVersion(shouldUseLiteVersion: boolean): void;
  useSecureYmAuth(shouldUseSecureYmAuth: boolean): void;

  // Theme configuration
  setThemeBotName(name: string): void;
  setThemeBotDescription(description: string): void;
  setThemePrimaryColor(color: string): void;
  setThemeSecondaryColor(color: string): void;
  setThemeBotBubbleBackgroundColor(color: string): void;
  setThemeBotIcon(iconUrl: string): void;
  setThemeBotClickIcon(iconUrl: string): void;
  setChatContainerTheme(theme: string): void;
  setThemeLinkColor(color: string): void;

  // Lifecycle
  startChatbot(): void;
  closeBot(): void;
  reloadBot(): void;
  revalidateToken(token: string, refreshSession: boolean): void;
  sendEventToBot(code: string, data: Object): void;

  // Async APIs (Promise-based — replaces old callback pattern)
  unlinkDeviceToken(
    botId: string,
    apiKey: string,
    deviceToken: string,
  ): Promise<boolean>;
  registerDevice(apiKey: string): Promise<boolean>;
  getUnreadMessagesCount(): Promise<string>;

  // Required by NativeEventEmitter
  addListener(eventType: string): void;
  removeListeners(count: number): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('YMChat');
