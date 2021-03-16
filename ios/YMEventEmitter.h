#import "RCTEventEmitter.h"
#import "RCTBridgeModule.h"

@interface YMEventEmitter : RCTEventEmitter <RCTBridgeModule>

@property (class, readonly) YMEventEmitter *shared;

@end
