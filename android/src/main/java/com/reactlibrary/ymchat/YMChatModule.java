package com.reactlibrary.ymchat;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.module.annotations.ReactModule;

@ReactModule(name = YMChatModule.NAME)
public class YMChatModule extends NativeYMChatSpec {

    public static final String NAME = "YMChat";

    private YMChatService ymChatService;

    public YMChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
        ymChatService = new YMChatService(reactContext);
    }

    @ReactMethod
    public void setBotId(String botId) {
        ymChatService.setBotId(botId);
    }

    @ReactMethod
    public void startChatbot() {
        try {
            ymChatService.startChatbot(getReactApplicationContext());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void closeBot() {
        ymChatService.closeBot();
    }

    @ReactMethod
    public void reloadBot() {
        ymChatService.reloadBot();
    }

    @ReactMethod
    public void revalidateToken(String token, boolean refreshSession) {
        try {
            ymChatService.revalidateToken(token, refreshSession);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void sendEventToBot(String code, ReadableMap data) {
        try {
            ymChatService.sendEventToBot(code, data);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void setDeviceToken(String token) {
        ymChatService.setDeviceToken(token);
    }

    @ReactMethod
    public void setEnableSpeech(boolean speech) {
        ymChatService.setEnableSpeech(speech);
    }

    @ReactMethod
    public void setAuthenticationToken(String token) {
        ymChatService.setAuthenticationToken(token);
    }

    @ReactMethod
    public void showCloseButton(boolean show) {
        ymChatService.showCloseButton(show);
    }

    @ReactMethod
    public void setCustomURL(String url) {
        ymChatService.customBaseUrl(url);
    }

    @ReactMethod
    public void setPayload(ReadableMap payload) {
        ymChatService.setPayload(payload);
    }

    @ReactMethod
    public void addKeyToPayload(String key, String value) {
        ymChatService.addKeyToPayload(key, value);
    }

    @ReactMethod
    public void unlinkDeviceToken(String botId, String apiKey, String deviceToken, Promise promise) {
        ymChatService.unlinkDeviceToken(botId, apiKey, deviceToken, promise);
    }

    @ReactMethod
    public void registerDevice(String apiKey, Promise promise) {
        ymChatService.registerDevice(apiKey, promise);
    }

    @ReactMethod
    public void getUnreadMessagesCount(Promise promise) {
        ymChatService.getUnreadMessagesCount(promise);
    }

    @ReactMethod
    public void setVersion(double version) {
        ymChatService.setVersion((int) version);
    }

    @ReactMethod
    public void setCustomLoaderURL(String url) {
        ymChatService.setCustomLoaderUrl(url);
    }

    @ReactMethod
    public void setStatusBarColor(String color) {
        ymChatService.setStatusBarColor(color);
    }

    @ReactMethod
    public void setCloseButtonColor(String color) {
        ymChatService.setCloseButtonColor(color);
    }

    @ReactMethod
    public void setDisableActionsOnLoad(boolean shouldDisableActionsOnLoad) {
        ymChatService.setDisableActionsOnLoad(shouldDisableActionsOnLoad);
    }

    @ReactMethod
    public void useLiteVersion(boolean shouldUseLiteVersion) {
        ymChatService.useLiteVersion(shouldUseLiteVersion);
    }

    @ReactMethod
    public void setMicIconColor(String color) {
        ymChatService.setMicIconColor(color);
    }

    @ReactMethod
    public void setMicBackgroundColor(String color) {
        ymChatService.setMicBackgroundColor(color);
    }

    @ReactMethod
    public void setMicButtonMovable(boolean shouldMicButtonMovable) {
        ymChatService.setMicButtonMovable(shouldMicButtonMovable);
    }

    @ReactMethod
    public void useSecureYmAuth(boolean shouldUseSecureYmAuth) {
        ymChatService.useSecureYmAuth(shouldUseSecureYmAuth);
    }

    @ReactMethod
    public void setOpenLinkExternally(boolean shouldOpenLinkExternally) {
        ymChatService.setOpenLinkExternally(shouldOpenLinkExternally);
    }

    @ReactMethod
    public void setThemeBotName(String name) {
        ymChatService.setThemeBotName(name);
    }

    @ReactMethod
    public void setThemeBotDescription(String description) {
        ymChatService.setThemeBotDescription(description);
    }

    @ReactMethod
    public void setThemePrimaryColor(String color) {
        ymChatService.setThemePrimaryColor(color);
    }

    @ReactMethod
    public void setThemeSecondaryColor(String color) {
        ymChatService.setThemeSecondaryColor(color);
    }

    @ReactMethod
    public void setThemeBotBubbleBackgroundColor(String color) {
        ymChatService.setThemeBotBubbleBackgroundColor(color);
    }

    @ReactMethod
    public void setThemeBotIcon(String iconUrl) {
        ymChatService.setThemeBotIcon(iconUrl);
    }

    @ReactMethod
    public void setThemeBotClickIcon(String iconUrl) {
        ymChatService.setThemeBotClickIcon(iconUrl);
    }

    @ReactMethod
    public void setChatContainerTheme(String theme) {
        ymChatService.setChatContainerTheme(theme);
    }

    @ReactMethod
    public void setThemeLinkColor(String color) {
        ymChatService.setThemeLinkColor(color);
    }

    @ReactMethod
    public void addListener(String eventName) {}

    @ReactMethod
    public void removeListeners(double count) {}
}
