//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>


@interface LetvHttpServerAPISignatureHelper : NSObject
LETV_SINGLETON_DECLARE(defaultHelper)
- (NSURLRequest* _Nullable) requestBySigningRequest: (NSURLRequest* _Nullable) request error: (NSError* _Nullable __autoreleasing* _Nullable) error;
@end
