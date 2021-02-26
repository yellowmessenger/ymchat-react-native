package com.reactlibrary;

import android.content.Context;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.reactlibrary.YmChatUtils.Utils;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;

import java.util.HashMap;

public class YMChatService {
    YMChat ymChat;

    HashMap<String, Object> payloadData = new HashMap<>();

    YMChatService() {
        this.ymChat = YMChat.getInstance();
    }

    public void setBotId(String botId) {
        ymChat.config = new YMConfig(botId);
        ymChat.config.ymAuthenticationToken = "";
        ymChat.config.payload = payloadData;
    }

    public void startChatbot(Context context) {
        ymChat.startChatbot(context);
    }

    public void closeBot() {
        ymChat.closeBot();
    }

    public void setDeviceToken(String token) {
        ymChat.config.deviceToken = token;
    }

    public void onEventFromBot(Callback callbackListener) {
        ymChat.onEventFromBot(botEvent -> {
            callbackListener.invoke(botEvent.getCode(), botEvent.getData());
        });
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

    public void setPayload(ReadableMap payload) {
        ymChat.config.payload.putAll(Utils.readableMapToHashMap(payload));
    }
}

