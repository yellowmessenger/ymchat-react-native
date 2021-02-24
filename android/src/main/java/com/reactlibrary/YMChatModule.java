
package com.reactlibrary;

import android.util.Log;
import android.widget.Toast;

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
  public void initialize(String botId)
  {
    Log.d("Android log","This is hai from android");
      ymChatService.setBotId(botId);
    Toast.makeText(reactContext,"Hi hello bayijaan",Toast.LENGTH_LONG).show();
  }
  
  @ReactMethod
  public void startChatBot()
  {
    ymChatService.startChatbot(reactContext);
  }

  @Override
  public String getName() {
    return "YMChat";
  }
}