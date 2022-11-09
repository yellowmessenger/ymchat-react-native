package com.reactlibrary.ymchat;

import android.content.Context;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.reactlibrary.ymchat.YmChatUtils.Utils;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;
import com.yellowmessenger.ymchat.models.YellowCallback;

import java.util.HashMap;

public class YMChatService {
    YMChat ymChat;

    HashMap<String, Object> payloadData = new HashMap<>();

    YMChatService(ReactApplicationContext reactContext) {
        this.ymChat = YMChat.getInstance();
        ymChat.onEventFromBot(botEvent -> {
            WritableMap params = Arguments.createMap();
            params.putString("code", botEvent.getCode());
            params.putString("data", botEvent.getData());
            reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("YMChatEvent", params);
        });
        ymChat.onBotClose(() -> reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("YMBotCloseEvent", null));
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

    public void setAuthenticationToken(String token) {
        ymChat.config.ymAuthenticationToken = token;
    }

    public void showCloseButton(boolean show) {
        ymChat.config.showCloseButton = show;
    }

    public void customBaseUrl(String url) {
        ymChat.config.customBaseUrl = url;
    }

    public void unlinkDeviceToken(String botId, String apiKey, String deviceToken, Callback callback) throws Exception {
        ymChat.unlinkDeviceToken(botId, apiKey, deviceToken, new YellowCallback() {
            @Override
            public void success() {
                callback.invoke(true);
            }

            @Override
            public void failure(String message) {
                callback.invoke(message);
            }
        });
    }

    public void unlinkDeviceToken(String apiKey, YMConfig ymConfig, Callback callback) throws Exception {
        ymChat.unlinkDeviceToken(apiKey, ymConfig, new YellowCallback() {
            @Override
            public void success() {
                callback.invoke(true);
            }

            @Override
            public void failure(String message) {
                callback.invoke(message);
            }
        });
    }

    public void registerDevice(String apiKey, YMConfig ymConfig, Callback callback) throws Exception {
        ymChat.registerDevice(apiKey, ymConfig, new YellowCallback() {
            @Override
            public void success() {
                callback.invoke(true);
            }

            @Override
            public void failure(String message) {
                callback.invoke(message);
            }
        });
    }

    public void getUnreadMessagesCount(YMConfig ymConfig, Callback callback) throws Exception {
        ymChat.getUnreadMessagesCount(ymConfig, new YellowCallback() {
            @Override
            public void success(String count) {
                callback.invoke(count);
            }

            @Override
            public void failure(String message) {
                callback.invoke(message);
            }
        });
    }

    public void setPayload(ReadableMap payload) {
        ymChat.config.payload.putAll(Utils.readableMapToHashMap(payload));
    }

    public void setVersion(int version) {
        ymChat.config.version = version;
    }

    public void setCustomLoaderUrl(String url) {
        ymChat.config.customLoaderUrl = url;
    }

    public void setStatusBarColor(String color) {
        ymChat.config.statusBarColorFromHex = color;
    }

    public void setCloseButtonColor(String color) {
        ymChat.config.closeButtonColorFromHex = color;
    }

    public void setDisableActionsOnLoad(boolean shouldDisableActionsOnLoad) {
        ymChat.config.disableActionsOnLoad = shouldDisableActionsOnLoad;
    }

    public void setUseLiteVersion(boolean useLiteVersion) {
        ymChat.config.useLiteVersion = useLiteVersion;
    }
}
