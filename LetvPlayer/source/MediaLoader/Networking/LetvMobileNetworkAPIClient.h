//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileAuthModuleTrait.h"
#import "LetvMobilePlayRequestModuleTrait.h"
#import "LetvMobilePlayAPIModel.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileNetworkAPIClient : NSObject <LetvMobileAuthModuleTrait>
@end

@interface LetvMobileNetworkAPIClient (AuthAPI)
- (RACSignal*) ltrx_loginWithPassport: (id<LetvMobileAuthPassportTrait>) passport;
- (RACSignal*) ltrx_logout;
@end

@interface LetvMobileNetworkAPIClient (PlayAPI)
- (RACSignal<LetvMobilePlayAPIModel*>*) ltrx_playAPI: (NSTimeInterval) timestamp
                        uid: (NSString*) uid
                        vid: (NSString*) vid
                   streamId: (NSString*) streamId;
@end
NS_ASSUME_NONNULL_END
