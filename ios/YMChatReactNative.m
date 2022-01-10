
#import "YMChatReactNative.h"
#import "YMEventEmitter.h"

@implementation YMChatReactNative

RCT_EXPORT_MODULE(YMChat);

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(setBotId:(NSString *)botId) {
    YMConfig *config = [[YMConfig alloc] initWithBotId:botId];
    YMChat.shared.config = config;
    YMChat.shared.enableLogging = true;
}

RCT_EXPORT_METHOD(startChatbot) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.delegate = self;
    [[YMChat shared] startChatbotWithAnimated:YES error: nil completion:nil];
}

RCT_EXPORT_METHOD(closeBot) {
    [[YMChat shared] closeBot];
}

RCT_EXPORT_METHOD(setEnableSpeech:(BOOL) speech) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.enableSpeech = speech;
}

RCT_EXPORT_METHOD(setAuthenticationToken:(NSString *) token) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.ymAuthenticationToken = token;
}

RCT_EXPORT_METHOD(setDeviceToken:(NSString *) token) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.deviceToken = token;
}

RCT_EXPORT_METHOD(setCustomURL:(NSString *) url) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customBaseUrl = url;
}

RCT_EXPORT_METHOD(showCloseButton:(BOOL) show) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.showCloseButton = show;
}

RCT_EXPORT_METHOD(setPayload:(NSDictionary *) payload) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.payload = payload;
}

RCT_EXPORT_METHOD(addKeyToPayload:(NSString *)key value:(NSString *)value) {
    assert(YMChat.shared.config != nil);
    NSMutableDictionary *dict = [YMChat.shared.config.payload mutableCopy];
    dict[key] = value;
    YMChat.shared.config.payload = dict;
}

RCT_EXPORT_METHOD(unlinkDeviceToken:(NSString *)botId apiKey:(NSString *)apiKey deviceToken:(NSString *)deviceToken callback:(RCTResponseSenderBlock)callback) {
    [[YMChat shared] unlinkDeviceTokenWithBotId:botId apiKey:apiKey deviceToken:deviceToken success:^{
        callback(@[@YES]);
        } failure:^(NSString * _Nonnull failureMessage) {
            callback(@[failureMessage]);
        }];
   
}

RCT_EXPORT_METHOD(setVersion:(NSInteger *) version) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.version = version;
}

RCT_EXPORT_METHOD(setCustomLoaderURL:(NSString *) url) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customLoaderUrl = url;
}

- (void)onEventFromBotWithResponse:(YMBotEventResponse *)response {
    if (YMEventEmitter.shared) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[@"code"] = response.code;
        if (response.data) {
            dict[@"data"] = response.data;
        }
        [YMEventEmitter.shared sendEventWithName:@"YMChatEvent" body:dict];
    }
}
- (void) onBotClose {
    if (YMEventEmitter.shared) {
        [YMEventEmitter.shared sendEventWithName:@"YMBotCloseEvent" body:nil];
    }
}

@end
