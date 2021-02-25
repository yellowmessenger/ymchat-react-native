package com.reactlibrary;

import android.content.Context;
import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.yellowmessenger.ymchat.BotEventListener;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;
import com.yellowmessenger.ymchat.models.YMBotEventResponse;

import java.security.Key;
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

    public void onEventFromBot(Callback callbackListener) {
        ymChat.onEventFromBot(botEvent -> {
            callbackListener.invoke(botEvent.getCode(), botEvent.getData());
        });
    }

    public void setEnableSpeech() {
        ymChat.config.enableSpeech = true;
    }

    public void setEnableHistory() {
        ymChat.config.enableHistory = true;
    }

    public void setAuthenticationToken(String token) {
        ymChat.config.ymAuthenticationToken = token;
    }

    public void showCloseButton() {
        ymChat.config.showCloseButton = true;
    }

    public void addPayload(String key, String value) {
        ymChat.config.payload.put(key, value);
    }
}

