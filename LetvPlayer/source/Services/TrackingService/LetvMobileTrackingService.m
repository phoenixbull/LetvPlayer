//
//  LetvMobileTrackingService.m
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/26.
//  Copyright © 2018 Letv. All rights reserved.
//

#import <LetvPlayer/LetvMobileNetworking.h>
#import "LetvMobileCDEInfoTrait.h"
#import "LetvMobileTrackingTrait.h"
#import "FixedTrackingParametersHelper.h"
#import "LetvMobileServicesContainer.h"
#import "LetvMobileTrackingService.h"

@interface TrackingServiceParametersProvider : NSObject <LetvMobileHTTPDefaultGETParametersTrait>
@property (nonatomic, copy) NSDictionary* defaultParameters;
- (instancetype) init NS_UNAVAILABLE;
@end

@interface LetvMobileTrackingService ()
@property (nonatomic, strong) FixedTrackingParametersHelper* helper;
@end

@implementation TrackingServiceParametersProvider
- (instancetype) init
{
    return nil;
}

- (instancetype) initWithDefaultParameters: (NSDictionary*) parameters
{
    self = [super init];
    if (self) {
        self.defaultParameters = parameters;
    }
    return self;
}
@end

@interface LetvMobileTrackingService ()
@property(nonatomic, strong) id<LetvMobileHTTPClientTrait> httpClient;
@property(nonatomic, strong) id<LetvMobileCDEInfoTrait> cdeInfo;
@end

@implementation LetvMobileTrackingService
LETV_SINGLETON_IMPL(sharedService)

- (void) startup
{
    // TODO: 启动, 发送失败的统计数据.
}

- (void) loginWithSessionId: (NSString*) sessionId;
{
    NSInteger tm = (NSInteger) [[NSDate date] timeIntervalSince1970];
    NSString* stime = [NSString stringWithFormat: @"%zd", tm];
    RACSignal* signal = [self.httpClient
                         rx_GET: @"/lg"
                         parameters: @{
                                       @"ctime": stime, //上报动作发生时客户端的时间，单位：毫秒
                                       @"stime": stime, //时间戳, 单位：毫秒
                                       @"uid": @"",
                                       
                                       @"apprunid": sessionId,
                                       @"nt": self.helper.networkType,
                                       @"os": self.helper.osName,
                                       @"r": self.helper.randomSeed,
                                       @"auid": self.helper.udid,
                                       @"bd": self.helper.vendor,
                                       @"idfa": self.helper.idfa,
                                       @"model": self.helper.model,
                                       }];
    [signal subscribeCompleted: ^(){}];
}

- (void) play_initWithLoginSessionId: (NSString*) loginSessionId
                       playSessionId: (NSString*) playSessionId
                                 vid: (NSString*) vid
                                  vt: (NSString*) vt
{

    NSDictionary* param = @{
                            @"ac": @"init",
                            @"vid": vid,
                            @"vt": vt,
                            @"apprunid": loginSessionId,
                            @"uuid": playSessionId,
                            };
    [self playWithParameters: param];
}


- (void) play_playWithLoginSessionId: (NSString*) loginSessionId
                       playSessionId: (NSString*) playSessionId
                                 vid: (NSString*) vid
                                  vt: (NSString*) vt
                                vlen: (NSString*) vlen
{
    NSDictionary* param = @{
                            @"ac": @"play",
                            @"vid": vid,
                            @"vt": vt,
                            @"vlen": vlen,
                            @"apprunid": loginSessionId,
                            @"uuid": playSessionId,
                            };
    [self playWithParameters: param];
}


- (void) play_finishWithLoginSessionId: (NSString*) loginSessionId
                         playSessionId: (NSString*) playSessionId
                                   vid: (NSString*) vid
                                    vt: (NSString*) vt
                                  vlen: (NSString*) vlen
                                    pt: (NSString*) pt
{
    NSDictionary* param = @{
                            @"ac": @"play",
                            @"vid": vid,
                            @"vt": vt,
                            @"vlen": vlen,
                            @"pt": pt,
                            @"apprunid": loginSessionId,
                            @"uuid": playSessionId,
                            };
    [self playWithParameters: param];
}

- (void) play_endWithLoginSessionId: (NSString*) loginSessionId
                      playSessionId: (NSString*) playSessionId
                               vid : (NSString*) vid
                                 vt: (NSString*) vt
                               vlen: (NSString*) vlen
                                 pt: (NSString*) pt
{
    NSDictionary* param = @{
                            @"ac": @"play",
                            @"vid": vid,
                            @"vt": vt,
                            @"vlen": vlen,
                            @"pt": pt,
                            @"apprunid": loginSessionId,
                            @"uuid": playSessionId,
                            };
    [self playWithParameters: param];
}

- (void) playWithParameters: (NSDictionary*) parameters

{
    NSInteger tm = (NSInteger) [[NSDate date] timeIntervalSince1970];
    NSString* stime = [NSString stringWithFormat: @"%zd", tm];
    NSString* cdeAppIdentifier = self.cdeInfo.appIdentifier;
    NSString* cdeVersionString = self.cdeInfo.versionString;
    if (cdeAppIdentifier.length == 0) {
        cdeAppIdentifier = @"-";
    }
    if (cdeVersionString.length == 0) {
        cdeVersionString = @"-";
    }
    
    NSDictionary* fixedParameters = @{
                                      @"ctime": stime,
                                      @"stime": stime,
                                      @"caid": cdeAppIdentifier,
                                      @"cdev": cdeVersionString,
                                      @"owner": @"1", //取值方式：枚举值 0：外网媒资；1：乐视网自有媒资
                                      @"ipt": @"0", // 取值方式：枚举值 0：直接点播 1：连播 2：切换码流
                                      @"joint": @"0", //0：无广告 1：有广告已拼接 2：有广告未拼接。
                                      @"pay": @"0", //
                                      /*
                                       上报满足条件：播放动作ac=play时必须上报，其他动作时不上报。
                                       取值方式：枚举值
                                       0：免费 1：收费视频试看 2：付费观看。
                                       乐视视频pay字段定义：
                                       1.普通账号用户和普通用户试看收费影片时上报pay=0；
                                       2.会员观看上报pay=1；
                                       3.观看免费影片时上报pay=2；
                                       4.点播影片观看时：用使用点播券观看上报pay=3。
                                       */
                                      
                                      @"prl": @"0", //
                                      /*
                                       0     点播
                                       1     直播
                                       2     轮播
                                       3     缓存播放
                                       4     播放本地视频
                                       5     主播直播
                                       6     点播联播
                                       7     点播联播模拟轮播
                                       8     芒果播放（临时占用）
                                       */
                                      @"plat": @"-", //平台标识
                                      /*
                                       取值方式：参考字典表取值
                                       平台标识字典由用户运营中心维护，如果使用了用户运营中心SDK，可以上报该字段
                                       */
                                      @"ref": @"-", //播放页来源地址
                                      
                                      @"ch": @"letv", // 取值方式：从应用获取 渠道号，pc/mh5视频推广渠道获取cur_url里?ch=的值，如果获取不到，统一填写为letv； 渠道指必须在战略合作部制定的渠道分类字典内
                                      @"pv": @"-", //取值方式：从应用获取 如果播放器自身没有版本号时上报应用版本号。
                                      @"nt": self.helper.networkType,
                                      @"r": self.helper.randomSeed,
                                      @"idfa": self.helper.idfa,
                                      };
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary: fixedParameters];
    [params addEntriesFromDictionary: parameters];
    
#if 0
    @"ac": @"", // init, play, finish, end.
    @"ctime": @"",
    @"stime": @"",
    @"vt": @"", //播放器的vtype
    // 取值方式：从媒资库获取
    //注：如果上报则cid、pid、vid必须与媒资库中的关系对应
    /*
     58 mp4_180
     21 mp4_350
     13 mp4_800
     22 mp4_1300
     51 mp4_720p
     */
    @"vid": @"-",
    @"pid": @"-",
    @"zid": @"-",
    @"cid": @"-", //上报满足条件： 能够获取到就要上报，使用乐视网媒资的必须上报
    
    @"pcode": @"",
    @"p1": @"",
    @"p2": @"",
    @"p3": @"",
    
    @"ty": @"", // 播放类型:
    @"vlen": @"", // 视频时长
    @"pt": @"", // 播放时长
    @"caid": @"", //cde的appid, 全端播放动作ac=init时必须上报,
    @"cdev": @"",
    /*
     上报满足条件：上报心跳动作time时必须上报播放时长，其他动作上报时不需要上报
     取值方式：动态创建
     单位：秒
     */
#endif
    
    // TODO: 失败的时候存储到文件.
    
    RACSignal* signal = [self.httpClient
                         rx_GET: @"/pl"
                         parameters: params];
    [signal subscribeCompleted: ^(){}];
}

#pragma mark -
#pragma mark getter

- (id<LetvMobileHTTPClientTrait>) httpClient
{
    if (!_httpClient) {
        id<LetvMobileTrackingTrait> trait = [LetvMobileServicesContainer.defaultContainer resolveProtocol: @protocol(LetvMobileTrackingTrait)];
        NSDictionary* parameters = @{
                                     @"pcode": trait.pcode,
                                     @"p1": trait.p1,
                                     @"p2": trait.p2,
                                     @"p3": trait.p3,
                                     };
        
        TrackingServiceParametersProvider* provider = [[TrackingServiceParametersProvider alloc] initWithDefaultParameters: parameters];
        
        _httpClient = [LetvMobileNetworkingFactory.defaultFactory
                       createHTTPClientWithBaseURLString: @"https://apple.www.letv.com"
                       secondsOfTimeout: 20
                       acceptableContentTypes: @[@"*/*"]
                       defaultGETParameters: provider
                       useSignature: NO];
        
    }
    return _httpClient;
}

- (id<LetvMobileCDEInfoTrait>) cdeInfo
{
    if (!_cdeInfo) {
        _cdeInfo = [LetvMobileServicesContainer.defaultContainer resolveProtocol: @protocol(LetvMobileCDEInfoTrait)];
    }
    return _cdeInfo;
}

- (FixedTrackingParametersHelper*) helper {
    if (!_helper) {
        _helper = [FixedTrackingParametersHelper defaultHelper];
    }
    
    return _helper;
}
@end
