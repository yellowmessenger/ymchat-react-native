package com.reactlibrary.ymchat.YmChatUtils;
import java.util.ArrayList;
import java.util.HashMap;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

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
                    HashMap<String, Object> attributes = readableMapToHashMap(readableMap.getMap(key));
                    map.put(key, attributes);
                    break;
                case Boolean:
                    map.put(key, readableMap.getBoolean(key) ? true : false);
                    break;
                case Number:
                    map.put(key, readableMap.getDouble(key));
                    break;
                case Array:
                    ReadableArray array = readableMap.getArray(key);
                    ArrayList<Object> arrayList = new ArrayList<>();
                    for (int i = 0; i < array.size(); i++) {
                        switch (array.getType(i)) {
                            case String:
                                arrayList.add(array.getString(i));
                                break;
                            case Map:
                                arrayList.add(readableMapToHashMap(array.getMap(i)));
                                break;
                            case Boolean:
                                arrayList.add(array.getBoolean(i) ? true : false);
                                break;
                            case Number:
                                arrayList.add(array.getDouble(i));
                                break;
                            case Array:
                                arrayList.add(parseNestedArray(array.getArray(i)));
                                break;
                            default:
                                // Handle unsupported types or do nothing
                                break;
                        }
                    }
                    map.put(key, arrayList);
                    break;
                default:
                    // Handle unsupported types or do nothing
                    break;
            }
        }
        return map;
    }

    private static ArrayList<Object> parseNestedArray(ReadableArray array) {
        ArrayList<Object> nestedArrayList = new ArrayList<>();
        for (int i = 0; i < array.size(); i++) {
            switch (array.getType(i)) {
                case String:
                    nestedArrayList.add(array.getString(i));
                    break;
                case Map:
                    nestedArrayList.add(readableMapToHashMap(array.getMap(i)));
                    break;
                case Boolean:
                    nestedArrayList.add(array.getBoolean(i) ? true : false);
                    break;
                case Number:
                    nestedArrayList.add(array.getDouble(i));
                    break;
                case Array:
                    nestedArrayList.add(parseNestedArray(array.getArray(i)));
                    break;
                default:
                    // Handle unsupported types or do nothing
                    break;
            }
        }
        return nestedArrayList;
    }
}
