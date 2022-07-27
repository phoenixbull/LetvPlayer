//
//  LetvPlayerSdkController.h
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2022/7/14.
//  Copyright © 2022 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetvPlayerManager.h"

typedef NS_ENUM(NSInteger, LetvMobilePlayerStreamCode) {
    LetvMobilePlayerStreamCodeUnknown = -1,   // 渣清
    LetvMobilePlayerStreamCodeLD = 0,   // 渣清
    LetvMobilePlayerStreamCodeMD = 1,   // 流畅
    LetvMobilePlayerStreamCodeSD = 2,   // 标清
    LetvMobilePlayerStreamCodeHD = 3,   // 高清
    LetvMobilePlayerStreamCodeTD = 4,   // 超清
};


@protocol LetvPlayerSdkControllerProtocol <NSObject>

- (void)LetvMobilePlayerControllerSuccess:(NSString *_Nullable)url useP2p:(BOOL)p2p metadata:(NSDictionary *_Nonnull)metaDict;

- (void)LetvMobilePlayerControllerFailed:(NSError *_Nullable)error useP2p:(BOOL)p2p;

@end


NS_ASSUME_NONNULL_BEGIN

@interface LetvPlayerSdkController : NSObject

@property (nonatomic, weak)id<LetvPlayerSdkControllerProtocol> delegate;



- (instancetype) initWithVid: (NSString*) vid p2p:(BOOL)useP2p
streamCode: (LetvMobilePlayerStreamCode) streamCode;

- (void)startProcess;

@end

NS_ASSUME_NONNULL_END
