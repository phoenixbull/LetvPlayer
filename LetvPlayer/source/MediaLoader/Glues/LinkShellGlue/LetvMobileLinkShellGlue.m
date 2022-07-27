//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "LetvCDE.h"
//#import <LetvCDE/LetvCDE.h>
#import <LetvPlayer/LetvSingleton.h>
#import "NSError+Letv.h"
#import "NSString+LetvHttpExtensions.h"
#import "LetvMobileLinkShellGlue.h"
#import "LetvMobileMediaLoaderDefaultParametersTrait.h"
#import "LetvMobileMediaLoaderContainer.h"

#define KIsiPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define KHWName ((KIsiPad)?@"ipad":@"iphone")

// 一级业务线代码 -- 移动部
#define LT_DATA_CENTER_P1VALUE  @"0"
// 二级业务线代码 -- 乐视视频
#define LT_DATA_CENTER_P2VALUE  @"00"

@interface LetvMobileLinkShellGlue ()
@property (nonatomic, strong) id<LetvMobileMediaLoaderDefaultParametersTrait> parametersTrait;
@end

@implementation LetvMobileLinkShellGlue
- (RACSignal<NSNumber*>*) ltrx_setup
{
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        dispatch_async(
                dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                ^{
                    initLinkShell();
                    [subscriber sendNext: @(YES)];
                    [subscriber sendCompleted];
                });
        return nil;
    }];

    return signal;
}

- (RACSignal<NSString*>*) ltrx_decryptURLString: (NSString*) urlString
{
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        const char* cryptCString = [urlString cStringUsingEncoding: [NSString defaultCStringEncoding]];
        char* decryptedCString = getURLFromLinkShell(cryptCString);
        if (!decryptedCString) {
            NSError* error = LETV_ERROR(LetvErrorCodeEmpty, @"LinkShell decrypt URL error.");
            [subscriber sendError: error];
        } else {
            NSString* s = [NSString stringWithCString: decryptedCString encoding: [NSString defaultCStringEncoding]];
            free(decryptedCString);
            [subscriber sendNext: s];
            [subscriber sendCompleted];
        }

        return nil;
    }];
    return signal;
}


- (NSString*)updateLinkShellDDUrl: (NSString*)originUrl videoId: (NSString*)videoId tokenFoPay:(NSString *)token
{
    NSString *newddUrl = originUrl;
    newddUrl = [self appendAntiStealingLinkParamsToDDUrl:newddUrl tokenFoPay:@"" urlKey:nil];
    newddUrl = [self appendOtherParamsToDDUrl:newddUrl videoId:videoId];
    return newddUrl;
}


// 添加防盗链参数到调度地址
- (NSString *)appendAntiStealingLinkParamsToDDUrl:(NSString *)ddUrl
                                       tokenFoPay:(NSString *)tokenForPay
                                           urlKey:(NSString *)urlKey
{

    NSString *iscpnValue = @"";//[SettingManager isUserLogin] ? @"f9050" : @"";
    NSString *userID = @"";
    NSString *userCenterUinfo = @"";
    NSString *token = @"";
    // 点播token
    token = tokenForPay;
    if (nil == token || token.length == 0) {
        NSString *errorLog = [NSString stringWithFormat:@"拼接g3地址时 token 为空 ，用户是否是会员：%d",0];
        NSLog(@"%@", errorLog);
    }
//    userCenterUinfo = [SettingManager getVipPriorUserInfo];

    //-----从session中获取uid（服务端返回），并注释上面从本地获取uid的逻辑---
    userID = @"";//self.session.uid;
    if (!userID || [userID isEqualToString:@""]) {
//        userID = [SettingManager getVipPriorUserId];
        NSString *msg = [NSString stringWithFormat:@"<防盗链处理>---本地获取的uid为：%@",userID];
        NSLog(msg);
    }
    else{
        NSString *msg = [NSString stringWithFormat:@"<防盗链处理>---uid为：%@",userID];
        NSLog(msg);
    }
            //--end--
    NSDictionary *urlParams = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"2",               @"termid",
                               iscpnValue,         @"iscpn",
                               userCenterUinfo,    @"uinfo",
                               token,              @"token",
                               userID,             @"uid",
                               @"macos",           @"ostype",
                               KHWName,            @"hwtype",
                               nil];

    // 点播tm、key
    NSString *url = [self appdendParamsToString:ddUrl params:urlParams];

    url = [NSString letv_replaceString:url keyword:@"format" toValue:@"1"];
    NSString *toValue = @"1";
//    if ([SettingManager getUTPEnabled] && ![SettingManager getCDEGrayEnabled]) {
//        toValue = @"3";
//    }

    url = [NSString letv_replaceString:url keyword:@"expect" toValue:toValue];

    // 直播单独增加key参数
//    if ((self.session.sessionMode == LeMPSessionModeLiving)) {
//
//        if (![NSString empty:urlKey]) {
//            url = [NSString stringWithFormat:@"%@&key=%@", url, [NSString safeString:urlKey]];
//        }
//
//    }

    return url;
}


- (NSString *)appendOtherParamsToDDUrl:(NSString *)ddUrl videoId:(NSString*)videoId{

    NSString *url = [self appendCommonParamsToDDUrl:ddUrl];

    // 上报需求
//    if (self.session.sessionMode != LeMPSessionModeLiving) {
        // 点播增加vid
        url = [NSString stringWithFormat:@"%@&vid=%@", url, [NSString letv_safeString:videoId]];
//    }

    return url;
}


- (NSString *)appendCommonParamsToDDUrl:(NSString *)ddUrl {

    NSString *url = [NSString stringWithString:ddUrl];

    NSString *m3vStr = nil;//[SettingManager getStringValueFromUserDefaults:kM3vValue];
    if(!m3vStr){
        m3vStr = @"3";
    }
    url = [NSString stringWithFormat:@"%@&m3v=%@", url, m3vStr];

    // 添加uuid用于cdn统计
    url = [NSString stringWithFormat:@"%@&uuid=%@", url, [NSString letv_safeString:[self getPlayUUID]]];

    // 如果地址中没有p1，则增加p1。上报需求
    NSRange range = [url rangeOfString:@"&p1="];
    if (range.length == 0) {
        url = [NSString stringWithFormat:@"%@&p1=%@", url, LT_DATA_CENTER_P1VALUE];
    }

    // 如果地址中没有p2, 则增加p2。上报需求
    range = [url rangeOfString:@"&p2="];
    if (range.length == 0) {
        url = [NSString stringWithFormat:@"%@&p2=%@", url, LT_DATA_CENTER_P2VALUE];
    }

    // 如果地址中没有pcode, 则增加pcode
    range = [url rangeOfString:@"&pcode="];
    if (range.length == 0) {
        url = [NSString stringWithFormat:@"%@&pcode=%@", url, self.parametersTrait.pcode];
    }

    // 如果地址中没有version, 则增加version
    range = [url rangeOfString:@"&version="];
    if (range.length == 0) {
        url = [NSString stringWithFormat:@"%@&version=%@", url, self.parametersTrait.version];
    }
    return url;
}


- (NSString *)appdendParamsToString:(NSString *)url params:(NSDictionary *)params {

    if (nil == url || url.length == 0) {
        return @"";
    }
    __block NSMutableString *urlTemp = [NSMutableString stringWithString:url];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *temp = [NSString stringWithFormat:@"&%@=%@", (NSString *)key, (NSString *)obj];
        [urlTemp appendString:temp];
    }];

    return urlTemp;
}


- (NSString *)getPlayUUID
{
    return @"";
}

- (id<LetvMobileMediaLoaderDefaultParametersTrait>) parametersTrait
{
    if (!_parametersTrait) {
        id<LetvMobileMediaLoaderDefaultParametersTrait> trait = [LetvMobileMediaLoaderContainer.defaultContainer resolveProtocol: @protocol(LetvMobileMediaLoaderDefaultParametersTrait)];
        _parametersTrait = trait;
    }
    return _parametersTrait;
}

@end
