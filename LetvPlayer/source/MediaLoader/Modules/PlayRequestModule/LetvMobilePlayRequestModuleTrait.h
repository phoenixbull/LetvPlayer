//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobilePlayRequestTrait <NSObject>
- (NSString*) valueForKey: (NSString*) key;
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobilePlayRequestModuleTrait <NSObject>
- (NSString*) valueForKey: (NSString*) key;
@end
NS_ASSUME_NONNULL_END
