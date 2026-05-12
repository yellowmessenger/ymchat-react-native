#ifdef RCT_NEW_ARCH_ENABLED
// New Architecture: conform to the Codegen-generated TurboModule spec.
#import <YMChatSpec/YMChatSpec.h>
@import YMChat;

@interface YMChatReactNative : NSObject <NativeYMChatSpec, YMChatDelegate>
@end

#else
// Old Architecture: RCTEventEmitter (superset of RCTBridgeModule) + YMChatDelegate.
#if __has_include("RCTEventEmitter.h")
#import "RCTBridgeModule.h"
#import "RCTEventEmitter.h"
#else
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#endif

@import YMChat;

// Extends RCTEventEmitter so this single module handles both method calls
// and native-to-JS event dispatch (replaces the old separate YMEventEmitter module).
@interface YMChatReactNative : RCTEventEmitter <RCTBridgeModule, YMChatDelegate>
@end

#endif
