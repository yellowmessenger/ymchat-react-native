package com.reactlibrary;

import android.content.Context;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.reactlibrary.YmChatUtils.Utils;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;

import java.util.HashMap;

public class YMChatService {
    YMChat ymChat;

    HashMap<String, Object> payloadData = new HashMap<>();

    YMChatService(ReactApplicationContext reactContext) {
        this.ymChat = YMChat.getInstance();
        ymChat.onEventFromBot(botEvent ->
        {
            WritableMap params = Arguments.createMap();
            params.putString("code", botEvent.getCode());
            params.putString("data", botEvent.getData());
            reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit("YMChatEvent",params);
        });
    }

    public void setBotId(String botId) {
        ymChat.config = new YMConfig(botId);
        ymChat.config.ymAuthenticationToken = "";
        ymChat.config.payload = payloadData;
    }

    public void startChatbot(Context context) {
        try {
            ymChat.startChatbot(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void closeBot() {
        ymChat.closeBot();
    }

    public void setDeviceToken(String token) {
        ymChat.config.deviceToken = token;
    }

    public void setEnableSpeech(boolean speech) {
        ymChat.config.enableSpeech = speech;
    }

    public void setEnableHistory(boolean history) {
        ymChat.config.enableHistory = history;
    }

    public void setAuthenticationToken(String token) {
        ymChat.config.ymAuthenticationToken = token;
    }

    public void showCloseButton(boolean show) {
        ymChat.config.showCloseButton = show;
    }
    public void customBaseUrl(String url) {
        ymChat.config.customBaseUrl = url;
    }

    public void setPayload(ReadableMap payload) {
        ymChat.config.payload.putAll(Utils.readableMapToHashMap(payload));
    }
}

