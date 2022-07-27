//
//  LetvTimestampModel.h
//  LetvMobileServices
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@protocol LetvTimestampModel
@end


@interface LetvTimestampModel : JSONModel
@property (nonatomic, copy, nonnull) NSString* dateString;
@property (nonatomic, copy, nonnull) NSString* weekDay;
@end
