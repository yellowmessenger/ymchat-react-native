//
//  YMEventEmitter.m
//  YMChatReactNative
//
//  Created by Kauntey Suryawanshi on 15/03/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import "YMEventEmitter.h"

@implementation YMEventEmitter

RCT_EXPORT_MODULE();

static YMEventEmitter * _shared;

+ (YMEventEmitter *)shared {
    return _shared;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"YMChatEvent"];
}

-(void)startObserving {
    _shared = self;
}

-(void)stopObserving {
    _shared = nil;
}

@end
