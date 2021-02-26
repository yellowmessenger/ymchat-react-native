
package com.reactlibrary;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;

public class YMChatModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private final YMChatService ymChatService = new YMChatService();

    public YMChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @ReactMethod
    public void setBotId(String botId) {
        ymChatService.setBotId(botId);
    }

    @ReactMethod
    public void startChatbot() {
        ymChatService.startChatbot(reactContext);
    }

    @ReactMethod
    public void closeBot() {
        ymChatService.closeBot();
    }

    @ReactMethod
    public void setDeviceToken(String token) {
        ymChatService.setDeviceToken(token);
    }

    @ReactMethod
    public void onEventFromBot(Callback callbackListener) {
        ymChatService.onEventFromBot(callbackListener);
    }

    @ReactMethod
    public void setEnableSpeech(boolean speech) {
        ymChatService.setEnableSpeech(speech);
    }

    @ReactMethod
    public void setEnableHistory(boolean history) {
        ymChatService.setEnableHistory(history);
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
    public void setPayload(ReadableMap payload) {
        ymChatService.setPayload(payload);
    }

    @Override
    public String getName() {
        return "YMChat";
    }

}