
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

@import YMChat;

@interface YMChatReact : NSObject <RCTBridgeModule, YMChatDelegate>

@end
  
