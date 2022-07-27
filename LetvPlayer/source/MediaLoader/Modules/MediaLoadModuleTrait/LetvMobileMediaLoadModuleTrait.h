//
//  LetvMobileVideoLoadModuleTrait.h
//  LetvMobilePlayerKit
//
//  Created by Kerberos Zhang on 2018/11/20.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>


/*
 * 输出 PlayableTrait, 数组, 或者 URLString 数组
 */
@protocol LetvMobileMediaLoadableTrait <NSObject>
@end

@protocol LetvMobileMediaTimelineTrait <NSObject>
@end


/*
 * 时间
 */
@interface LetvMobileMediaTimeline : NSObject
@end


typedef NS_ENUM(NSInteger, LetvMobileMediaContentType) {
    LetvMobileMediaContentTypeAdvertise,            // 广告
    LetvMobileMediaContentTypeOpening,              // 片头
    LetvMobileMediaContentTypeMovie,                // 正片
    LetvMobileMediaContentTypeEnding,               // 片尾
};


@interface LetvMobileMediaTimelineSegment : NSObject
@property (nonatomic, assign) NSTimeInterval begin;
@property (nonatomic, assign) NSTimeInterval end;
@property (nonatomic, assign) LetvMobileMediaContentType type;
@end


@protocol LetvMobileMediaPlayableTrait <NSObject>
@end


/*
 * ?? 码流需要输入
 * ?? 是否是全景需要输入
 * ?? 其他输入参数
 * ?? 统计
 */

@protocol LetvMobileMediaLoadModuleTrait <NSObject>
- (RACSignal<id<LetvMobileMediaPlayableTrait>>*) ltrx_loadMediaWith: (id<LetvMobileMediaLoadableTrait>) loadable;
- (RACSignal<id<LetvMobileMediaPlayableTrait>>*) ltrx_fallbackWith: (NSError*) error;
@end
