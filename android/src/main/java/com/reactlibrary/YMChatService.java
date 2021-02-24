package com.reactlibrary;

import android.content.Context;

import com.yellowmessenger.ymchat.BotEventListener;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;
import com.yellowmessenger.ymchat.models.YMBotEventResponse;

import java.util.HashMap;

public class YMChatService {
    // Dummy bot id. (Purrs a lot)
    String botId ;
    YMConfig config;
    HashMap<String, Object> payloadData;
    YMChat ymChat;

    YMChatService()
    {
       this.ymChat =  YMChat.getInstance();
    }

    void setBotId(String botId){
        ymChat.config = new YMConfig(botId);
    }

    void startChatbot(Context context)
    {
        ymChat.startChatbot(context);
    }

    void EventListener(BotEventListener eventListener)
    {
        ymChat.onEventFromBot(eventListener);
    }
}

