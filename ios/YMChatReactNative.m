
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
    [[YMChat shared] startChatbotWithAnimated:true completion:nil];
}

RCT_EXPORT_METHOD(closeBot) {
    [[YMChat shared] closeBot];
}

RCT_EXPORT_METHOD(setEnableSpeech:(BOOL) speech) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.enableSpeech = speech;
}

RCT_EXPORT_METHOD(setEnableHistory:(BOOL) history) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.enableHistory = history;
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

@end
