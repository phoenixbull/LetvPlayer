//
//  LetvMobileMediaLoader.m
//  LetvMobilePlayerKit
//
//  Created by Kerberos Zhang on 2018/11/20.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <LetvPlayer/LetvMobileServices.h>
#import "LetvMobileNetworkAPIClient.h"
#import "LetvMobilePlayAPIModel.h"
#import "LetvMobileLinkShellModuleTrait.h"
#import "LetvMobileLinkShellService.h"
#import "LetvMobileCDEGlue.h"
#import "LetvMobileCDEService.h"
#import "LetvMobileCDNGlue.h"
#import "LetvMobileCDNParseService.h"
#import "NSString+LetvHttpExtensions.h"

#import "LetvMobileMediaLoader.h"

@interface LetvMobileMediaLoader ()
@property(nonatomic, strong, readonly) id<LetvMobileTimestampServiceTrait> timestampService;
@property(nonatomic, strong, readonly) id<LetvMobileLinkShellModuleTrait> linkshellService;
@property(nonatomic, strong, readonly) LetvMobileCDEService* cdeService;
@property(nonatomic, strong) LetvMobileNetworkAPIClient* playAPIClient;
@property(nonatomic, strong)LetvMobileCDNParseService *cdnParseService;
@property(nonatomic, strong) id<LetvMobileCDETaskTrait> task;
@end

@implementation LetvMobileMediaLoader
LETV_SINGLETON_IMPL(shared)

- (void)dealloc
{
    [self.task stop];
}

- (instancetype) init {
    self = [super init];
    
    return self;
}

- (RACSignal<NSString*>*) ltrx_loadWithVid: (NSString*) vid streamId: (NSString*) streamId
{
    @weakify(self);
    RACSignal* signal = [[[[self.timestampService ltrx_requestTimestamp]
     flattenMap:^(NSNumber * _Nonnull timestamp) {
         @strongify(self);
         return [self.playAPIClient ltrx_playAPI: [timestamp floatValue] uid: @"" vid: vid streamId: streamId];
     }]
     flattenMap:^(LetvMobilePlayAPIModel* model) {
         if (model.videoFileModel.streamErrorCode) {
             NSError* error = nil;
             if (nil == model || nil == model.videoFileModel || nil == model.videoFileModel.supportedRates) {
                 error = LETV_ERROR(LetvErrorCodeEmpty,@"bit rate empty");
             }else {
                 error = [NSError errorWithDomain:@"bit rate empty" code:LetvErrorCodeEmpty userInfo:[NSDictionary dictionaryWithObject:model.videoFileModel.supportedRates forKey:NSLocalizedDescriptionKey]];
             }
            return [RACSignal error: error];
         }
         LetvMobilePlayAPIVideoBitRateModel* rateInfoModel = model.videoFileModel.rateModel;
         NSString* videoUrl = rateInfoModel.mainUrl;
         if ([NSString letv_isBlankString:videoUrl]) {
             NSError* error = nil;
             if (nil == model || nil == model.videoFileModel || nil == model.videoFileModel.supportedRates) {
                 error = LETV_ERROR(LetvErrorCodeEmpty,@"video url empty");
             }else {
                 error = [NSError errorWithDomain:@"video url empty" code:LetvErrorCodeEmpty userInfo:[NSDictionary dictionaryWithObject:model.videoFileModel.supportedRates forKey:NSLocalizedDescriptionKey]];
             }
             return [RACSignal error: error];
         }
        @strongify(self);
        return [RACSignal return: [self appdendParamsToString:videoUrl playModel:model tokenForPay:nil]];

     }]
     flattenMap:^(NSString* videoUrl) {
         @strongify(self);
#ifdef DEBUG
         NSLog(@"org: %@", videoUrl);
#endif
         return [self.linkshellService ltrx_decryptURLString: videoUrl];
     }];
    
#ifdef DEBUG
    signal = [[signal
               doNext: ^(NSString* url) {
                   NSLog(@"linkshelled: %@", url);
               }]
              doError:^(NSError * _Nonnull error) {
                  NSLog(@"%@", error);
              }];
#endif
    
    signal = [[[signal
              flattenMap: ^(NSString* url) {
                  @strongify(self);
                  return [self.cdeService startTaskWithURLString: url];
              }]
              doNext:^(id<LetvMobileCDETaskTrait> task) {
                  @strongify(self);
                  self.task = task;
              }]
              map: ^(id<LetvMobileCDETaskTrait> task) {
                  return task.hostedURLString;
              }];
    
    return signal;
}



- (RACSignal<NSDictionary*>*_Nonnull) ltrx_loadWithVid: (NSString* _Nullable) vid streamId:(NSString *) streamId uid:(NSString *)uid p2p:(BOOL)isUseP2p {
    @weakify(self);
    RACSignal* signal = [[[[self.timestampService ltrx_requestTimestamp]
         flattenMap:^(NSNumber * _Nonnull timestamp) {
             @strongify(self);
             return [self.playAPIClient ltrx_playAPI: [timestamp floatValue] uid: uid vid: vid streamId: streamId];
         }]
         flattenMap:^(LetvMobilePlayAPIModel* model) {
             if (model.videoFileModel.streamErrorCode) {
                 NSError* error = nil;
                 if (nil == model || nil == model.videoFileModel || nil == model.videoFileModel.supportedRates) {
                     error = LETV_ERROR(LetvErrorCodeEmpty,@"bit rate empty");
                 }else {
                     error = [NSError errorWithDomain:@"bit rate empty" code:LetvErrorCodeEmpty userInfo:[NSDictionary dictionaryWithObject:model.videoFileModel.supportedRates forKey:NSLocalizedDescriptionKey]];
                 }
                return [RACSignal error: error];
             }
             LetvMobilePlayAPIVideoBitRateModel* rateInfoModel = model.videoFileModel.rateModel;
             NSString* videoUrl = rateInfoModel.mainUrl;
             if ([NSString letv_isBlankString:videoUrl]) {
                 NSError* error = nil;
                 if (nil == model || nil == model.videoFileModel || nil == model.videoFileModel.supportedRates) {
                     error = LETV_ERROR(LetvErrorCodeEmpty,@"video url empty");
                 }else {
                     error = [NSError errorWithDomain:@"video url empty" code:LetvErrorCodeEmpty userInfo:[NSDictionary dictionaryWithObject:model.videoFileModel.supportedRates forKey:NSLocalizedDescriptionKey]];
                 }

                 return [RACSignal error: error];
             }
            @strongify(self);
             return [RACSignal return: [self appdendParamsToString:videoUrl playModel:model tokenForPay:nil]];
         }]
         flattenMap:^(NSString* videoUrl) {
             @strongify(self);
    #ifdef DEBUG
             NSLog(@"org: %@", videoUrl);
    #endif
             return [self.linkshellService ltrx_decryptURLString: videoUrl];
         }];

    #ifdef DEBUG
        signal = [[signal
                   doNext: ^(NSString* url) {
                       NSLog(@"linkshelled: %@", url);
                   }]
                  doError:^(NSError * _Nonnull error) {
                      NSLog(@"%@", error);
                  }];
    #endif

    if (isUseP2p) {
        signal = [[[signal
        flattenMap: ^(NSString* url) {
            @strongify(self);
            return [self.cdeService startTaskWithURLString: url];
        }]
        doNext:^(id<LetvMobileCDETaskTrait> task) {
            @strongify(self);
            self.task = task;
        }]
        map: ^(id<LetvMobileCDETaskTrait> task) {
            return @{@"cdeurl":[NSString letv_safeString:task.hostedURLString],@"cdnurl":@"",@"p2p":@"1",@"streamid":streamId};
        }];
    }else {
        signal = [[signal flattenMap:^(NSString* url) {
            @strongify(self);
            return [self.cdnParseService ltrx_parseURLString:url];
        }]
        map:^(NSString* url) {
            return @{@"cdeurl":@"",@"cdnurl":[NSString letv_safeString:url],@"p2p":@"0",@"streamid":streamId};
        }];
    }
    return signal;
}


- (NSString *)appdendParamsToString:(NSString *)url playModel:(LetvMobilePlayAPIModel*) model tokenForPay:(NSString *)token {
    if (model && model.validateModel && model.validateModel.data
        && [model.validateModel.data.status integerValue] == 1
        && ![NSString letv_isBlankString: model.validateModel.data.token]) {
        NSDictionary *urlParams = [NSDictionary dictionaryWithObjectsAndKeys:
        model.validateModel.data.token,              @"token",
        model.validateModel.data.uid,             @"uid",
        nil];
        if (nil == url || url.length == 0) {
            return @"";
        }
        __block NSMutableString *urlTemp = [NSMutableString stringWithString:url];
        [urlParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *temp = [NSString stringWithFormat:@"&%@=%@", (NSString *)key, (NSString *)obj];
            [urlTemp appendString:temp];
        }];
        return urlTemp;
    }else {
        return url;
    }
}


#pragma mark -
#pragma mark getter

- (id<LetvMobileTimestampServiceTrait>) timestampService {
    return [LetvMobileServicesFactory.defaultFactory createTimestampService];
}

- (id<LetvMobileLinkShellModuleTrait>) linkshellService {
    return [LetvMobileLinkShellService sharedService];
}

- (LetvMobileCDEService*) cdeService {
    return [LetvMobileCDEService sharedService];
}

- (LetvMobileNetworkAPIClient*) playAPIClient {
    if (!_playAPIClient) {
        _playAPIClient = [LetvMobileNetworkAPIClient new];
    }
    return _playAPIClient;
}

- (id<LetvMobileCDNModuleTrait>) cdnParseService {
    if (!_cdnParseService) {
        _cdnParseService = [LetvMobileCDNParseService new];
    }
    return _cdnParseService;
}

@end

NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileServicesCDEInfoProvider : NSObject <LetvMobileCDEInfoTrait>
@property(nonatomic, copy, readonly) NSString* appIdentifier;
@property(nonatomic, copy, readonly) NSString* versionString;
@end
NS_ASSUME_NONNULL_END

@implementation LetvMobileServicesCDEInfoProvider
- (NSString*) appIdentifier
{
    return [LetvMobileCDEGlue.sharedGlue appId];
}

- (NSString*) versionString
{
    return [LetvMobileCDEGlue.sharedGlue versionString];
}
@end

extern void LetvMobileMediaLoader_Initialize()
{
    LetvMobileServicesCDEInfoProvider* provider = [[LetvMobileServicesCDEInfoProvider alloc] init];
    
    [LetvMobileServicesContainer.defaultContainer injectProtocol: @protocol(LetvMobileCDEInfoTrait) useBlock: ^{
        return provider;
    }];
}
