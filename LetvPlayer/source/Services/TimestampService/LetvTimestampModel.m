//
//  LetvTimestampModel.m
//  LetvMobileServices
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import "LetvMobileModels.h"

#import "LetvTimestampModel.h"


@implementation LetvTimestampModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
        @"dateString": @"date",
        @"weekDay": @"week_day",
    }
    LETV_DECLARE_KEYMAPPER_END()
}
@end
