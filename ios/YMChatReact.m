
#import "YMChatReact.h"
#import <React/RCTLog.h>

@implementation YMChatReact {
  NSMutableArray<RCTResponseSenderBlock> *_onBotEvent;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(YMChat)

RCT_EXPORT_METHOD(setBotId:(NSString *)botId) {
  YMConfig *config = [[YMConfig alloc] initWithBotId:botId];
  YMChat.shared.config = config;
  YMChat.shared.enableLogging = true;
}

RCT_EXPORT_METHOD(startChatbot) {
  assert(YMChat.shared.config != nil);
  NSArray<UIWindow *> *windows = UIApplication.sharedApplication.windows;
  UIWindow *window = windows.firstObject;
  UIViewController *root = window.rootViewController;
  [[YMChat shared] startChatbotWithAnimated:true completion:nil];
}

RCT_EXPORT_METHOD(closeBot) {
  [[YMChat shared] closeBot];
}

RCT_EXPORT_METHOD(onEventFromBot: (RCTResponseSenderBlock) callback) {
  YMChat.shared.delegate = self;
  _onBotEvent = [NSMutableArray new];
  [_onBotEvent addObject:callback];
}


RCT_EXPORT_METHOD(setEnableSpeech:(BOOL)speech) {
  YMChat.shared.config.enableSpeech = speech;
}

RCT_EXPORT_METHOD(setEnableHistory:(BOOL)history) {
  YMChat.shared.config.enableHistory = history;
}

RCT_EXPORT_METHOD(setPayload:(NSDictionary *)payload) {
  YMChat.shared.config.payload = payload;
}

RCT_EXPORT_METHOD(addKeyToPayload:(NSString *)key value:(NSString *)value) {
  NSMutableDictionary *dict = [YMChat.shared.config.payload mutableCopy];
  dict[key] = value;
  YMChat.shared.config.payload = dict;
}

- (void)onEventFromBotWithResponse:(YMBotEventResponse *)response {
  RCTResponseSenderBlock callback = _onBotEvent[0];
  callback(@[response.code, response.data ? : @""]);
}

@end
  
