//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <LetvPlayer/LetvMobileNetworking.h>
#import "LetvMobileMediaLoaderContainer.h"
#import "AFHTTPSessionManager+Rx.h"
#import "LetvMobilePlayAPIModel.h"
#import "LetvMobileMediaLoaderDefaultParametersTrait.h"
#import "LetvMobileNetworkAPIClient.h"

NS_ASSUME_NONNULL_BEGIN
@interface MediaLoaderNetworkDefaultParametersProvider : NSObject <LetvMobileHTTPDefaultGETParametersTrait>
@property (nonatomic, strong) id<LetvMobileMediaLoaderDefaultParametersTrait> trait;
@end
NS_ASSUME_NONNULL_END

@implementation MediaLoaderNetworkDefaultParametersProvider
- (instancetype) init {
    return nil;
}

- (instancetype) initWithTrait: (id<LetvMobileMediaLoaderDefaultParametersTrait>) trait
{
    self = [super init];
    if (self) {
        self.trait = trait;
    }
    return self;
}

- (NSDictionary*) defaultParameters {
    NSDictionary* dict = @{
                           @"pcode": self.trait.pcode,
                           @"version": self.trait.version,
                           };
    return dict;
}
@end

@interface LetvMobileNetworkAPIClient ()
@property (nonatomic, strong) id<LetvMobileHTTPClientTrait> httpClient;
@property (nonatomic, copy) NSString* productiveServerBaseURLString;
@property (nonatomic, copy) NSString* testingServerBaseURLString;

@property (nonatomic, strong) id<LetvMobileMediaLoaderDefaultParametersTrait> parametersTrait;

@end

@implementation LetvMobileNetworkAPIClient
#pragma mark -
#pragma mark initialize & finalize
- (instancetype) init
{
    self = [super init];
    if (self) {
//#ifdef DEBUG
//        _testingServerBaseURLString = @"http://t-sdk-mob-app.le.com";
//        _productiveServerBaseURLString = @"http://sdk-mob-app.le.com";
//#else
        _productiveServerBaseURLString = @"https://sdk-mob-app.le.com";
        _testingServerBaseURLString = @"http://t-sdk-mob-app.le.com";
//#endif

    }

    return self;
}

#pragma mark -
#pragma mark getter

- (id<LetvMobileHTTPClientTrait>) httpClient
{
    if (!_httpClient) {
        // TODO: test api.
        id<LetvMobileMediaLoaderDefaultParametersTrait> trait = self.parametersTrait;
        MediaLoaderNetworkDefaultParametersProvider* provider = [[MediaLoaderNetworkDefaultParametersProvider alloc] initWithTrait: trait];
       id<LetvMobileHTTPClientTrait> client = [LetvMobileNetworkingFactory.defaultFactory
                                               createJSONClientWithBaseURLString: self.productiveServerBaseURLString
                                               secondsOfTimeout: 30
                                               acceptableContentTypes: nil
                                               defaultGETParameters: provider
                                               useSignature: YES];
        _httpClient = client;
    }
    return _httpClient;
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

@implementation LetvMobileNetworkAPIClient (AuthAPI)
#pragma mark -
#pragma mark Authorize API

- (RACSignal*) ltrx_loginWithPassport: (id<LetvMobileAuthPassportTrait>) passport
{
    RACSignal* signal = [self.httpClient rx_GET: @"/mgtv/thirdgetuser" parameters: @{
            @"ostype"     : @"ios",         // 操作系统名称
            @"src"        : @"mgtv",        //
            @"invoker"    : @"letv",        //
            @"osversion"  : @"",            // 系统版本
            @"appversion" : @"",            // 应用版本
            @"phonetype"  : @"",            // 手机类型, iPhone5, iPhone5s, iPhoneX 等
            @"mac"        : @"",            // MAC 地址
            @"openudid"   : @"",            //
            @"idfa"       : @"",            //
            @"dname"      : @"",            // 设备名称, "张川的手机" 等
            @"ticket"     : passport,       //
    }];
    // TODO: model
    return signal;
}

- (RACSignal*) ltrx_logout
{
    return [RACSignal empty];
}
@end


@implementation LetvMobileNetworkAPIClient (PlayAPI)
- (RACSignal<LetvMobilePlayAPIModel*>*) ltrx_playAPI: (NSTimeInterval) timestamp
                        uid: (NSString*) uid
                        vid: (NSString*) vid
                   streamId: (NSString*) streamId
{
    RACSignal* signal = [self.httpClient rx_GET: @"/play" parameters: @{
            @"tss"         : @"ios",        // 播放平台
            @"playid"      : @"0",           // 播放类型: 0 => 点播, 1 => 直播, 2 => 下载.
            @"tm"          : @((NSUInteger)timestamp),           // 时间戳
            @"uid"         : uid,              // Letv 用户 ID.
            @"vid"         : vid,           // vid
            @"tss"         : @"ios",
            @"rate"        : streamId.length ? streamId : @""
            //@"_debug"       : @"1",
    }];
    
    signal = [signal ltrx_mapModel: [LetvMobilePlayAPIModel class]];
    return signal;
}
@end
