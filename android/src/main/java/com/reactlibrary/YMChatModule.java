
package com.reactlibrary;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class YMChatModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private final YMChatService ymChatService = new YMChatService();

    public YMChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @ReactMethod
    public void setBotId(String botId) {
        Log.d("YMChat Android", "Inititalizing chatbot.");
        ymChatService.setBotId(botId);
    }

    @ReactMethod
    public void startChatbot() {
        ymChatService.startChatbot(reactContext);
    }

    public void closeBot() {
        ymChatService.closeBot();
    }

    @ReactMethod
    public void onEventFromBot(Callback callbackListener) {
        ymChatService.onEventFromBot(callbackListener);
    }

    @ReactMethod
    public void setEnableSpeech() {
        ymChatService.setEnableSpeech();
    }

    @ReactMethod
    public void setEnableHistory() {
        ymChatService.setEnableHistory();
    }

    @ReactMethod
    public void setAuthenticationToken(String token) {
        ymChatService.setAuthenticationToken(token);
    }

    @ReactMethod
    public void showCloseButton() {
        ymChatService.showCloseButton();
    }


    @ReactMethod
    public void setPayload(String key, String value) {
        ymChatService.addPayload(key, value);
    }

    @Override
    public String getName() {
        return "YMChat";
    }

}