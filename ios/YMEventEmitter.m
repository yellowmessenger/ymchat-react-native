#import "YMEventEmitter.h"

@implementation YMEventEmitter

RCT_EXPORT_MODULE();

static YMEventEmitter * _shared;

+ (YMEventEmitter *)shared {
    return _shared;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"YMChatEvent", @"YMBotCloseEvent", @"YMBotLoadFailedEvent"];
}

-(void)startObserving {
    _shared = self;
}

-(void)stopObserving {
    _shared = nil;
}

@end
