
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

RCT_EXPORT_METHOD(reloadBot) {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    [[YMChat shared] reloadBotAndReturnError: nil];
}

RCT_EXPORT_METHOD(revalidateToken:(NSString *)token refreshSession:(BOOL)refreshSession) {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    [[YMChat shared] revalidateTokenWithToken:token refreshSession:refreshSession error:nil];
}

RCT_EXPORT_METHOD(sendEventToBot:(NSString *)code data:(NSDictionary *)data) {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    
    YMEventModel *event = [[YMEventModel alloc] initWithCode:code data:data];
    [[YMChat shared] sendEventToBotWithEvent:event error:nil];
}

RCT_EXPORT_METHOD(setEnableSpeech:(BOOL) speech) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.enableSpeech = speech;
}

RCT_EXPORT_METHOD(setMicButtonMovable:(BOOL) shouldMicButtonMovable) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.isButtonMovable = shouldMicButtonMovable;
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

RCT_EXPORT_METHOD(registerDevice:(NSString *)apiKey callback:(RCTResponseSenderBlock)callback) {
    assert(YMChat.shared.config != nil);
    [[YMChat shared] registerDeviceWithApiKey:apiKey ymConfig:YMChat.shared.config success:^{
        callback(@[@YES]);
        } failure:^(NSString * _Nonnull failureMessage) {
            callback(@[failureMessage]);
        }];
}

RCT_EXPORT_METHOD(getUnreadMessagesCount:(RCTResponseSenderBlock)callback) {
    assert(YMChat.shared.config != nil);
    [[YMChat shared] getUnreadMessagesCountWithYmConfig:YMChat.shared.config success:^(NSString * _Nonnull count){
        callback(@[count]);
    } failure:^(NSString * _Nonnull failureMessage) {
        callback(@[failureMessage]);
    }];
}

RCT_EXPORT_METHOD(useLiteVersion:(BOOL) shouldUseLiteVersion) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.useLiteVersion = shouldUseLiteVersion;
}

RCT_EXPORT_METHOD(setVersion:(NSInteger *) version) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.version = version;
}

RCT_EXPORT_METHOD(setCustomLoaderURL:(NSString *) url) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customLoaderUrl = url;
}

RCT_EXPORT_METHOD(setStatusBarColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.statusBarColor = [self getColorFromHexString:color];
    
}

RCT_EXPORT_METHOD(setCloseButtonColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.closeButtonColor = [self getColorFromHexString:color];
}

RCT_EXPORT_METHOD(setDisableActionsOnLoad:(BOOL) shouldDisableActionsOnLoad) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.disableActionsOnLoad = shouldDisableActionsOnLoad;
}

RCT_EXPORT_METHOD(setMicIconColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.fabIconColor = [self getColorFromHexString:color];
}

RCT_EXPORT_METHOD(setMicBackgroundColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.fabBackgroundColor = [self getColorFromHexString:color];
}

RCT_EXPORT_METHOD(useSecureYmAuth:(BOOL) shouldUseSecureYmAuth) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.useSecureYmAuth = shouldUseSecureYmAuth;
}

RCT_EXPORT_METHOD(setThemeBotName:(NSString *) name) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botName = name;
}

RCT_EXPORT_METHOD(setThemeBotDescription:(NSString *) description) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botDescription = description;
}

RCT_EXPORT_METHOD(setThemePrimaryColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.primaryColor = [self getColorFromHexString:color];
}

RCT_EXPORT_METHOD(setThemeSecondaryColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.secondaryColor = [self getColorFromHexString:color];
}

RCT_EXPORT_METHOD(setThemeBotBubbleBackgroundColor:(NSString *) color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botBubbleBackgroundColor = [self getColorFromHexString:color];
}

RCT_EXPORT_METHOD(setThemeBotIcon:(NSString *) iconUrl) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botIcon = iconUrl;
}

RCT_EXPORT_METHOD(setThemeBotClickIcon:(NSString *) iconUrl) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botClickIcon = iconUrl;
}

RCT_EXPORT_METHOD(setChatContainerTheme:(NSString *) theme) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.chatBotTheme = theme;
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

- (UIColor *)getColorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([(NSString*) hexString characterAtIndex:0] == '#') {
        [scanner setScanLocation:1]; // bypass '#' character
    } else {
        [scanner setScanLocation:0];
    }
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
