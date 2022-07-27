//
//  LetvMobileModel.h
//  LetvMobileModels
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


#define LETV_DECLARE_KEYMAPPER_BEGIN() \
    static JSONKeyMapper* objectMapping = nil; \
    static dispatch_once_t _onceToken##objectMapping = 0; \
    dispatch_once(&_onceToken##objectMapping, ^() { \
    objectMapping = [[JSONKeyMapper alloc] initWithModelToJSONDictionary:

#define LETV_DECLARE_KEYMAPPER_END() \
    ]; \
    }); \
    return objectMapping;

// 返回数据状态
typedef NS_ENUM(NSInteger, LetvDataState)
{
    LetvDataStateNormal         = 1,    // 数据正常
    LetvDataStateEmpty          = 2,    // 数据为空
    LetvDataStateAbnormal       = 3,    // 数据异常
    LetvDataStateNotChange      = 4,    // 数据无变化
    LetvDataStateTokenExpired   = 5,    // tv_token过期
    LetvDataStateIPBanned       = 6,    // IP被屏蔽
};


@protocol LetvResponseModelHeaderError <NSObject>
@property (nonatomic, readonly) NSInteger code;
@property (nonatomic, readonly) NSString* content;
@end

@interface LetvResponseModelHeaderError : JSONModel <LetvResponseModelHeaderError>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString<Optional>* content;
@end

@protocol LetvResponseModelHeader <NSObject>
@property (nonatomic, readonly) LetvDataState state;
@property (nonatomic, readonly) NSString* markId;
@property (nonatomic, strong) id<LetvResponseModelHeaderError> error;
@end

@interface LetvResponseModelHeader : JSONModel <LetvResponseModelHeader>
@property (nonatomic, assign) LetvDataState state;
@property (nonatomic, strong) NSString<Optional>* markId;
@property (nonatomic, strong) LetvResponseModelHeaderError<Optional>* error;
@end

@protocol LetvResponseModel <NSObject>
@property (nonatomic, strong) id<LetvResponseModelHeader> header;
@property (nonatomic, strong) id payload;
@end

@interface LetvResponseModel : JSONModel <LetvResponseModel>
@property (nonatomic, strong) LetvResponseModelHeader* header;
@property (nonatomic, strong) NSDictionary<Optional>* payload;
@end

// 从调度地址到真正地址的解析, 这里使用纯协议,方便使用不同的数据传输格式
@protocol LeMPDispatchNodeModel <NSObject>
@property (nonatomic, assign) NSInteger goneCode;
@property (nonatomic, copy) NSString* urlString;
@end


@protocol LeMPDispatchModel <NSObject>
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, assign) NSTimeInterval startTimestamp;
@property (nonatomic, assign) NSTimeInterval endTimestamp;
@property (nonatomic, assign) NSTimeInterval currentTimestamp;
@property (nonatomic, assign) NSTimeInterval shiftTimeInterval;
@property (nonatomic, copy) NSString* mainUrlString;
@property (nonatomic, strong) NSArray<LeMPDispatchNodeModel>* nodeSubmodels;
@end

@protocol LTGSLBNodeModel @end
@interface LTGSLBNodeModel : JSONModel <LeMPDispatchNodeModel>
@property (nonatomic, assign) NSInteger goneCode;
@property (nonatomic, copy) NSString* urlString;
@end

@protocol LTGSLBModel @end
@interface LTGSLBModel : JSONModel <LeMPDispatchModel>
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, assign) NSTimeInterval startTimestamp;
@property (nonatomic, assign) NSTimeInterval endTimestamp;
@property (nonatomic, assign) NSTimeInterval currentTimestamp;
@property (nonatomic, assign) NSTimeInterval shiftTimeInterval;
@property (nonatomic, copy) NSString* mainUrlString;
@property (nonatomic, strong) NSArray<LTGSLBNodeModel, Optional>* nodeSubmodels;
@end
