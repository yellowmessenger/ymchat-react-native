#import "YMChatReactNative.h"

// ---------------------------------------------------------------------------
// New Architecture (TurboModule) implementation
// ---------------------------------------------------------------------------
#ifdef RCT_NEW_ARCH_ENABLED

#import <ReactCommon/RCTTurboModule.h>

@implementation YMChatReactNative

RCT_EXPORT_MODULE(YMChat);

// --- Helpers ----------------------------------------------------------------

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:([hexString characterAtIndex:0] == '#') ? 1 : 0];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                           green:((rgbValue & 0xFF00) >> 8) / 255.0
                            blue:(rgbValue & 0xFF) / 255.0
                           alpha:1.0];
}

// --- TurboModule bridge --------------------------------------------------

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeYMChatSpecJSI>(params);
}

// --- Bot configuration --------------------------------------------------

- (void)setBotId:(NSString *)botId {
    YMConfig *config = [[YMConfig alloc] initWithBotId:botId];
    YMChat.shared.config = config;
    YMChat.shared.enableLogging = true;
}

- (void)setAuthenticationToken:(NSString *)token {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.ymAuthenticationToken = token;
}

- (void)setDeviceToken:(NSString *)token {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.deviceToken = token;
}

- (void)setCustomURL:(NSString *)url {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customBaseUrl = url;
}

- (void)setPayload:(NSDictionary *)payload {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.payload = payload;
}

- (void)addKeyToPayload:(NSString *)key value:(NSString *)value {
    assert(YMChat.shared.config != nil);
    NSMutableDictionary *dict = [YMChat.shared.config.payload mutableCopy];
    dict[key] = value;
    YMChat.shared.config.payload = dict;
}

- (void)setVersion:(double)version {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.version = (NSInteger)version;
}

- (void)setCustomLoaderURL:(NSString *)url {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customLoaderUrl = url;
}

// --- UI configuration ---------------------------------------------------

- (void)showCloseButton:(BOOL)show {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.showCloseButton = show;
}

- (void)setStatusBarColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.statusBarColor = [self colorFromHexString:color];
}

- (void)setCloseButtonColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.closeButtonColor = [self colorFromHexString:color];
}

- (void)setDisableActionsOnLoad:(BOOL)shouldDisableActionsOnLoad {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.disableActionsOnLoad = shouldDisableActionsOnLoad;
}

- (void)setOpenLinkExternally:(BOOL)shouldOpenLinkExternally {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.shouldOpenLinkExternally = shouldOpenLinkExternally;
}

// --- Speech configuration -----------------------------------------------

- (void)setEnableSpeech:(BOOL)speech {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.enableSpeech = speech;
}

- (void)setMicButtonMovable:(BOOL)shouldMicButtonMovable {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.isButtonMovable = shouldMicButtonMovable;
}

- (void)setMicIconColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.fabIconColor = [self colorFromHexString:color];
}

- (void)setMicBackgroundColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.fabBackgroundColor = [self colorFromHexString:color];
}

// --- Feature flags ------------------------------------------------------

- (void)useLiteVersion:(BOOL)shouldUseLiteVersion {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.useLiteVersion = shouldUseLiteVersion;
}

- (void)useSecureYmAuth:(BOOL)shouldUseSecureYmAuth {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.useSecureYmAuth = shouldUseSecureYmAuth;
}

// --- Theme configuration ------------------------------------------------

- (void)setThemeBotName:(NSString *)name {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botName = name;
}

- (void)setThemeBotDescription:(NSString *)description {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botDescription = description;
}

- (void)setThemePrimaryColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.primaryColor = [self colorFromHexString:color];
}

- (void)setThemeSecondaryColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.secondaryColor = [self colorFromHexString:color];
}

- (void)setThemeBotBubbleBackgroundColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botBubbleBackgroundColor = [self colorFromHexString:color];
}

- (void)setThemeBotIcon:(NSString *)iconUrl {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botIcon = iconUrl;
}

- (void)setThemeBotClickIcon:(NSString *)iconUrl {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botClickIcon = iconUrl;
}

- (void)setChatContainerTheme:(NSString *)theme {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.chatBotTheme = theme;
}

- (void)setThemeLinkColor:(NSString *)color {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.linkColor = [self colorFromHexString:color];
}

// --- Lifecycle ----------------------------------------------------------

- (void)startChatbot {
    assert(YMChat.shared.config != nil);
    YMChat.shared.delegate = self;
    [[YMChat shared] startChatbotWithAnimated:YES error:nil completion:nil];
}

- (void)closeBot {
    [[YMChat shared] closeBot];
}

- (void)reloadBot {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    [[YMChat shared] reloadBotAndReturnError:nil];
}

- (void)revalidateToken:(NSString *)token refreshSession:(BOOL)refreshSession {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    [[YMChat shared] revalidateTokenWithToken:token refreshSession:refreshSession error:nil];
}

- (void)sendEventToBot:(NSString *)code data:(NSDictionary *)data {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    YMEventModel *event = [[YMEventModel alloc] initWithCode:code data:data];
    [[YMChat shared] sendEventToBotWithEvent:event error:nil];
}

// --- Async APIs (Promises) ----------------------------------------------

- (void)unlinkDeviceToken:(NSString *)botId
                   apiKey:(NSString *)apiKey
              deviceToken:(NSString *)deviceToken
                  resolve:(RCTPromiseResolveBlock)resolve
                   reject:(RCTPromiseRejectBlock)reject {
    [[YMChat shared] unlinkDeviceTokenWithBotId:botId
                                         apiKey:apiKey
                                    deviceToken:deviceToken
                                        success:^{ resolve(@YES); }
                                        failure:^(NSString * _Nonnull msg) {
                                            reject(@"UNLINK_FAILED", msg, nil);
                                        }];
}

- (void)registerDevice:(NSString *)apiKey
               resolve:(RCTPromiseResolveBlock)resolve
                reject:(RCTPromiseRejectBlock)reject {
    assert(YMChat.shared.config != nil);
    [[YMChat shared] registerDeviceWithApiKey:apiKey
                                     ymConfig:YMChat.shared.config
                                      success:^{ resolve(@YES); }
                                      failure:^(NSString * _Nonnull msg) {
                                          reject(@"REGISTER_FAILED", msg, nil);
                                      }];
}

- (void)getUnreadMessagesCount:(RCTPromiseResolveBlock)resolve
                        reject:(RCTPromiseRejectBlock)reject {
    assert(YMChat.shared.config != nil);
    [[YMChat shared] getUnreadMessagesCountWithYmConfig:YMChat.shared.config
                                               success:^(NSString * _Nonnull count) { resolve(count); }
                                               failure:^(NSString * _Nonnull msg) {
                                                   reject(@"UNREAD_FAILED", msg, nil);
                                               }];
}

// --- Event listener stubs (required by NativeEventEmitter spec) ---------

- (void)addListener:(NSString *)eventType {}
- (void)removeListeners:(double)count {}

// --- YMChatDelegate callbacks -------------------------------------------

- (void)onEventFromBotWithResponse:(YMBotEventResponse *)response {
    // Under New Architecture events are sent via the emitter in the spec;
    // for now we use RCTEventEmitter's sendEventWithName when available,
    // otherwise post via device event through the bridge if present.
}

- (void)onBotClose {
}

- (void)onBotLoadFailed {
}

@end

// ---------------------------------------------------------------------------
// Old Architecture implementation
// ---------------------------------------------------------------------------
#else

#import <React/RCTBridge.h>

@implementation YMChatReactNative

RCT_EXPORT_MODULE(YMChat);

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"YMChatEvent", @"YMBotCloseEvent", @"YMBotLoadFailedEvent"];
}

// --- Helpers ----------------------------------------------------------------

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:([hexString characterAtIndex:0] == '#') ? 1 : 0];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                           green:((rgbValue & 0xFF00) >> 8) / 255.0
                            blue:(rgbValue & 0xFF) / 255.0
                           alpha:1.0];
}

// --- Bot configuration --------------------------------------------------

RCT_EXPORT_METHOD(setBotId:(NSString *)botId) {
    YMConfig *config = [[YMConfig alloc] initWithBotId:botId];
    YMChat.shared.config = config;
    YMChat.shared.enableLogging = true;
}

RCT_EXPORT_METHOD(setAuthenticationToken:(NSString *)token) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.ymAuthenticationToken = token;
}

RCT_EXPORT_METHOD(setDeviceToken:(NSString *)token) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.deviceToken = token;
}

RCT_EXPORT_METHOD(setCustomURL:(NSString *)url) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customBaseUrl = url;
}

RCT_EXPORT_METHOD(setPayload:(NSDictionary *)payload) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.payload = payload;
}

RCT_EXPORT_METHOD(addKeyToPayload:(NSString *)key value:(NSString *)value) {
    assert(YMChat.shared.config != nil);
    NSMutableDictionary *dict = [YMChat.shared.config.payload mutableCopy];
    dict[key] = value;
    YMChat.shared.config.payload = dict;
}

RCT_EXPORT_METHOD(setVersion:(NSNumber *)version) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.version = [version integerValue];
}

RCT_EXPORT_METHOD(setCustomLoaderURL:(NSString *)url) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customLoaderUrl = url;
}

// --- UI configuration ---------------------------------------------------

RCT_EXPORT_METHOD(showCloseButton:(BOOL)show) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.showCloseButton = show;
}

RCT_EXPORT_METHOD(setStatusBarColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.statusBarColor = [self colorFromHexString:color];
}

RCT_EXPORT_METHOD(setCloseButtonColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.closeButtonColor = [self colorFromHexString:color];
}

RCT_EXPORT_METHOD(setDisableActionsOnLoad:(BOOL)shouldDisableActionsOnLoad) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.disableActionsOnLoad = shouldDisableActionsOnLoad;
}

RCT_EXPORT_METHOD(setOpenLinkExternally:(BOOL)shouldOpenLinkExternally) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.shouldOpenLinkExternally = shouldOpenLinkExternally;
}

// --- Speech configuration -----------------------------------------------

RCT_EXPORT_METHOD(setEnableSpeech:(BOOL)speech) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.enableSpeech = speech;
}

RCT_EXPORT_METHOD(setMicButtonMovable:(BOOL)shouldMicButtonMovable) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.isButtonMovable = shouldMicButtonMovable;
}

RCT_EXPORT_METHOD(setMicIconColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.fabIconColor = [self colorFromHexString:color];
}

RCT_EXPORT_METHOD(setMicBackgroundColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.speechConfig.fabBackgroundColor = [self colorFromHexString:color];
}

// --- Feature flags ------------------------------------------------------

RCT_EXPORT_METHOD(useLiteVersion:(BOOL)shouldUseLiteVersion) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.useLiteVersion = shouldUseLiteVersion;
}

RCT_EXPORT_METHOD(useSecureYmAuth:(BOOL)shouldUseSecureYmAuth) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.useSecureYmAuth = shouldUseSecureYmAuth;
}

// --- Theme configuration ------------------------------------------------

RCT_EXPORT_METHOD(setThemeBotName:(NSString *)name) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botName = name;
}

RCT_EXPORT_METHOD(setThemeBotDescription:(NSString *)description) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botDescription = description;
}

RCT_EXPORT_METHOD(setThemePrimaryColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.primaryColor = [self colorFromHexString:color];
}

RCT_EXPORT_METHOD(setThemeSecondaryColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.secondaryColor = [self colorFromHexString:color];
}

RCT_EXPORT_METHOD(setThemeBotBubbleBackgroundColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botBubbleBackgroundColor = [self colorFromHexString:color];
}

RCT_EXPORT_METHOD(setThemeBotIcon:(NSString *)iconUrl) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botIcon = iconUrl;
}

RCT_EXPORT_METHOD(setThemeBotClickIcon:(NSString *)iconUrl) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.botClickIcon = iconUrl;
}

RCT_EXPORT_METHOD(setChatContainerTheme:(NSString *)theme) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.chatBotTheme = theme;
}

RCT_EXPORT_METHOD(setThemeLinkColor:(NSString *)color) {
    assert(YMChat.shared.config != nil);
    if (YMChat.shared.config.theme == nil) { YMChat.shared.config.theme = [[YMTheme alloc] init]; }
    YMChat.shared.config.theme.linkColor = [self colorFromHexString:color];
}

// --- Lifecycle ----------------------------------------------------------

RCT_EXPORT_METHOD(startChatbot) {
    assert(YMChat.shared.config != nil);
    YMChat.shared.delegate = self;
    [[YMChat shared] startChatbotWithAnimated:YES error:nil completion:nil];
}

RCT_EXPORT_METHOD(closeBot) {
    [[YMChat shared] closeBot];
}

RCT_EXPORT_METHOD(reloadBot) {
    assert(YMChat.shared.config != nil && YMChat.shared.viewController != nil);
    [[YMChat shared] reloadBotAndReturnError:nil];
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

// --- Async APIs (Promises) ----------------------------------------------

RCT_EXPORT_METHOD(unlinkDeviceToken:(NSString *)botId
                  apiKey:(NSString *)apiKey
                  deviceToken:(NSString *)deviceToken
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    [[YMChat shared] unlinkDeviceTokenWithBotId:botId
                                         apiKey:apiKey
                                    deviceToken:deviceToken
                                        success:^{ resolve(@YES); }
                                        failure:^(NSString * _Nonnull msg) {
                                            reject(@"UNLINK_FAILED", msg, nil);
                                        }];
}

RCT_EXPORT_METHOD(registerDevice:(NSString *)apiKey
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    assert(YMChat.shared.config != nil);
    [[YMChat shared] registerDeviceWithApiKey:apiKey
                                     ymConfig:YMChat.shared.config
                                      success:^{ resolve(@YES); }
                                      failure:^(NSString * _Nonnull msg) {
                                          reject(@"REGISTER_FAILED", msg, nil);
                                      }];
}

RCT_EXPORT_METHOD(getUnreadMessagesCount:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    assert(YMChat.shared.config != nil);
    [[YMChat shared] getUnreadMessagesCountWithYmConfig:YMChat.shared.config
                                               success:^(NSString * _Nonnull count) { resolve(count); }
                                               failure:^(NSString * _Nonnull msg) {
                                                   reject(@"UNREAD_FAILED", msg, nil);
                                               }];
}

// --- YMChatDelegate callbacks -------------------------------------------

- (void)onEventFromBotWithResponse:(YMBotEventResponse *)response {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"code"] = response.code;
    if (response.data) { dict[@"data"] = response.data; }
    [self sendEventWithName:@"YMChatEvent" body:dict];
}

- (void)onBotClose {
    [self sendEventWithName:@"YMBotCloseEvent" body:nil];
}

- (void)onBotLoadFailed {
    [self sendEventWithName:@"YMBotLoadFailedEvent" body:nil];
}

@end

#endif
