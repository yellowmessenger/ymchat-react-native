package com.reactlibrary;

import android.content.Context;

import com.yellowmessenger.ymchat.BotEventListener;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;
import com.yellowmessenger.ymchat.models.YMBotEventResponse;

import java.util.HashMap;

public class YMChatService {
    YMChat ymChat;

    YMChatService()
    {
       this.ymChat =  YMChat.getInstance();
    }

    public void setBotId(String botId){
        ymChat.config = new YMConfig(botId);
        HashMap<String, Object> payloadData = new HashMap<>();
        ymChat.config.payload = payloadData;
    }

    public void startChatbot(Context context)
    {
        ymChat.startChatbot(context);
    }

    public void EventListener(BotEventListener eventListener)
    {
        ymChat.onEventFromBot(eventListener);
    }
}

