package com.reactlibrary.ymchat;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

public class YMChatModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private YMChatService ymChatService;

    public YMChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        ymChatService = new YMChatService(reactContext);
    }

    @ReactMethod
    public void setBotId(String botId) {
        ymChatService.setBotId(botId);
    }

    @ReactMethod
    public void startChatbot() {
        try {
            ymChatService.startChatbot(reactContext);
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
    public void unlinkDeviceToken(String botId, String apiKey, String deviceToken, Callback callback) throws Exception {
        ymChatService.unlinkDeviceToken(botId, apiKey, deviceToken, callback);
    }

    @ReactMethod
    public void registerDevice(String apiKey, Callback callback) throws Exception {
        ymChatService.registerDevice(apiKey, callback);
    }

    @ReactMethod
    public void getUnreadMessagesCount(Callback callback) throws Exception {
        ymChatService.getUnreadMessagesCount(callback);
    }

    @ReactMethod
    public void setVersion(int version) {
        ymChatService.setVersion(version);
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
    public void useSecureYmAuth(boolean shouldUseSecureYmAuth) {
        ymChatService.useSecureYmAuth(shouldUseSecureYmAuth);
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
    public void setThemeBotIcon(String iconUrl) {
        ymChatService.setThemeBotIcon(iconUrl);
    }

    @ReactMethod
    public void setThemeBotClickIcon(String iconUrl) {
        ymChatService.setThemeBotClickIcon(iconUrl);
    }

    @Override
    public String getName() {
        return "YMChat";
    }

}