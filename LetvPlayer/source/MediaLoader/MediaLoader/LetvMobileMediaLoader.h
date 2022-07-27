//
//  LetvMobileMediaLoader.h
//  LetvMobilePlayerKit
//
//  Created by Kerberos Zhang on 2018/11/20.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvMobileCore.h>


@interface LetvMobileMediaLoader : NSObject
LETV_SINGLETON_DECLARE(shared)
- (instancetype _Nonnull ) init;

/// 返回播放地址 p2p url
/// @param vid 视频id
/// @param streamId 视频码率
- (RACSignal<NSString*>*_Nonnull) ltrx_loadWithVid: (NSString* _Nullable) vid streamId: (NSString*) streamId;


/// 返回播放地址（json串）
/// @param vid 视频id
/// @param streamId 视频码流
/// @param uid 用户id
/// @param isUseP2p 是否使用p2p
- (RACSignal<NSDictionary*>*_Nonnull) ltrx_loadWithVid: (NSString* _Nullable) vid streamId:(NSString *) streamId uid:(NSString *)uid p2p:(BOOL)isUseP2p;


@end

extern void LetvMobileMediaLoader_Initialize(void);
