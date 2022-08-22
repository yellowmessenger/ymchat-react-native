package com.reactlibrary.ymchat.YmChatUtils;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

import java.util.HashMap;

public class Utils {
    public static HashMap<String, Object> readableMapToHashMap(ReadableMap readableMap) {
        if (readableMap == null) {
            return null;
        }
        HashMap<String, Object> map = new HashMap<String, Object>();
        ReadableMapKeySetIterator keySetIterator = readableMap.keySetIterator();
        while (keySetIterator.hasNextKey()) {
            String key = keySetIterator.nextKey();
            ReadableType type = readableMap.getType(key);
            switch (type) {
                case String:
                    map.put(key, readableMap.getString(key));
                    break;
                case Map:
                    HashMap<String, Object> attributes = new Utils().readableMapToHashMap(readableMap.getMap(key));
                    map.put(key, attributes);
                    break;
                default:
                    // do nothing
            }
        }
        return map;
    }
}
