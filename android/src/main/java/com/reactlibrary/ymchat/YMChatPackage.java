package com.reactlibrary.ymchat;

import androidx.annotation.NonNull;

import com.facebook.react.TurboReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.module.model.ReactModuleInfo;
import com.facebook.react.module.model.ReactModuleInfoProvider;
import com.facebook.react.uimanager.ViewManager;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class YMChatPackage extends TurboReactPackage {

    @Override
    public NativeModule getModule(@NonNull String name, @NonNull ReactApplicationContext reactContext) {
        if (name.equals(YMChatModule.NAME)) {
            return new YMChatModule(reactContext);
        }
        return null;
    }

    @Override
    public ReactModuleInfoProvider getReactModuleInfoProvider() {
        return () -> {
            Map<String, ReactModuleInfo> moduleInfos = new HashMap<>();
            boolean isTurboModule = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED;
            moduleInfos.put(
                YMChatModule.NAME,
                new ReactModuleInfo(
                    YMChatModule.NAME,
                    YMChatModule.class.getName(),
                    false,  // canOverrideExistingModule
                    false,  // needsEagerInit
                    false,  // hasConstants
                    false,  // isCxxModule
                    isTurboModule
                )
            );
            return moduleInfos;
        };
    }

    @Override
    public List<ViewManager> createViewManagers(@NonNull ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }
}
