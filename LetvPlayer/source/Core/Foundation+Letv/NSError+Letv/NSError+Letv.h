//
//  NSError+Letv.h
//  LetvMobileCore
//
//  Created by Kerberos Zhang on 2018/11/23.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>


const extern NSErrorDomain LetvErrorDomain;

typedef NS_ENUM(NSInteger, LetvErrorCode)
{
    LetvErrorCodeNoError        =  0, // 无错误
    LetvErrorCodeGeneric        = -1, // 未知错误
    LetvErrorCodeNetwork        = -2, // 网络错误
    LetvErrorCodeJSON           = -3, // 数据解析错误
    LetvErrorCodeEmpty          = -4, // 空数据
    LetvErrorCodeAuth           = -5, // 验证错误
    LetvErrorCodeIllegalData    = -6, // 数据非法
};


#define LETV_ERROR(code, reason) \
({ \
        NSError* error = letv_error_new(code, reason, __FILE__, __LINE__); \
        error; \
})

extern NSError* letv_error_new(LetvErrorCode code, NSString* reason, char* file, int line);


@interface NSError (Letv)
+ (instancetype) letv_errorWithError: (NSError*) error;
+ (instancetype) letv_errorWithCode: (LetvErrorCode) code reason: (NSString*) reason;

+ (instancetype) letv_errorWithCode: (LetvErrorCode) code reason: (NSString*) reason file: (char*) file line: (NSInteger) line;
@end
