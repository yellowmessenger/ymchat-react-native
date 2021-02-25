
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
    public void initialize(String botId) {
        Log.d("YMChat Android", "Inititalizing chatbot.");
        ymChatService.setBotId(botId);
    }

    @ReactMethod
    public void startChatBot() {
        ymChatService.startChatbot(reactContext);
    }

    @ReactMethod
    public void eventListener(Callback callbackListener) {
    ymChatService.eventListener(callbackListener);
    }

    @ReactMethod
    public void addPayload(String key, String value) {
        ymChatService.addPayload(key, value);
    }

    @Override
    public String getName() {
        return "YMChat";
    }
}