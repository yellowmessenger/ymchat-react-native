//
//  Emitter.h
//  YMChatReactNative
//
//  Created by Kauntey Suryawanshi on 15/03/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import "RCTEventEmitter.h"
#import "RCTBridgeModule.h"

@interface YMEventEmitter : RCTEventEmitter <RCTBridgeModule>

@property (class, readonly) YMEventEmitter *shared;

@end
