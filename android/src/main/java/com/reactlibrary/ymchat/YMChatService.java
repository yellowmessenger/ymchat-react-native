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
import com.yellowmessenger.ymchat.models.YellowDataCallback;
import com.yellowmessenger.ymchat.models.YellowUnreadMessageResponse;
import com.yellowmessenger.ymchat.models.YMEventModel;
import com.yellowmessenger.ymchat.models.YMTheme;

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

    public void reloadBot() {
        ymChat.reloadBot();
    }

    public void revalidateToken(String token, boolean refreshSession) {
        try {
            ymChat.revalidateToken(token, refreshSession);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendEventToBot(String code, ReadableMap data)  {
        try {
            YMEventModel model = new YMEventModel(code, Utils.readableMapToHashMap(data));
            ymChat.sendEventToBot(model);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDeviceToken(String token) {
        ymChat.config.deviceToken = token;
    }

    public void setEnableSpeech(boolean speech) {
        ymChat.config.speechConfig.enableSpeech = speech;
    }

    public void setButtonMovable(boolean shouldButtonMovable) {
        ymChat.config.speechConfig.isButtonMovable = shouldButtonMovable;
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

    public void registerDevice(String apiKey, Callback callback) {
        try {
            ymChat.registerDevice(apiKey, ymChat.config, new YellowCallback() {
                @Override
                public void success() {
                    callback.invoke(true);
                }

                @Override
                public void failure(String message) {
                    callback.invoke(message);
                }
            });
        } catch (Exception e) {
            callback.invoke(e.getMessage());
        }
    }

    public void getUnreadMessagesCount(Callback callback) {
        try {
            ymChat.getUnreadMessagesCount(ymChat.config, new YellowDataCallback() {
                @Override
                public <T> void success(T data) {
                    YellowUnreadMessageResponse response = (YellowUnreadMessageResponse) data;
                    callback.invoke(response.getUnreadCount());
                }

                @Override
                public void failure(String message) {
                    HashMap<String, String> errorObject = new HashMap<String, String>();
                    errorObject.put("error", message);
                    callback.invoke(errorObject);
                }
            });
        } catch (Exception e) {
            callback.invoke(e.getMessage());
        }
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

    public void useLiteVersion(boolean shouldUseLiteVersion) {
        ymChat.config.useLiteVersion = shouldUseLiteVersion;
    }

    public void setMicIconColor(String color) {
        ymChat.config.speechConfig.fabIconColor = color;
    }

    public void setMicBackgroundColor(String color) {
        ymChat.config.speechConfig.fabBackgroundColor = color;
    }

    public void useSecureYmAuth(boolean shouldUseSecureYmAuth) {
        ymChat.config.useSecureYmAuth = shouldUseSecureYmAuth;
    }

    public void setThemeBotName(String name) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.botName = name;
    }

    public void setThemeBotDescription(String description) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.botDesc = description;
    }

    public void setThemePrimaryColor(String color) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.primaryColor = color;
    }

    public void setThemeSecondaryColor(String color) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.secondaryColor = color;
    }

    public void setThemeBotBubbleBackgroundColor(String color) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.botBubbleBackgroundColor = color;
    }

    public void setThemeBotIcon(String iconUrl) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.botIcon = iconUrl;
    }

    public void setThemeBotClickIcon(String iconUrl) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.botClickIcon = iconUrl;
    }

    public void setChatContainerTheme(String theme) {
        if (ymChat.config.theme == null) { ymChat.config.theme = new YMTheme(); }
        ymChat.config.theme.chatBotTheme = theme;
    }
}
