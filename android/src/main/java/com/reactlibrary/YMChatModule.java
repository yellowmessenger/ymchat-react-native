
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class YMChatModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private final YMChatService ymChatService= new YMChatService();

  public YMChatModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @ReactMethod
  void initialize(String botId)
  {
      ymChatService.setBotId(botId);
  }
  
  @ReactMethod
  void startChatBot()
  {
    ymChatService.startChatbot(reactContext);
  }

  @Override
  public String getName() {
    return "YMChat";
  }
}