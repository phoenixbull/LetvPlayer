//
//  LetvMobileModel.m
//  LetvMobileModels
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import "LetvMobileModel.h"

@implementation LetvResponseModelHeaderError
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"code": @"code",
      @"content": @"content",
    }
    LETV_DECLARE_KEYMAPPER_END()
}

@end

@implementation LetvResponseModelHeader
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"state": @"status",
      @"markId": @"markid",
    }
    LETV_DECLARE_KEYMAPPER_END()
}
@end

@implementation LetvResponseModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"header": @"header",
      @"payload": @"body",
    }
    LETV_DECLARE_KEYMAPPER_END()
}
@end

@implementation LTGSLBNodeModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
        @"goneCode" :@"gone",
        @"urlString" :@"location",
    }
    LETV_DECLARE_KEYMAPPER_END()
}

@end

@implementation LTGSLBModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
        @"statusCode": @"status",
        @"errorCode" : @"ercode",
        @"startTimestamp" : @"starttime",
        @"endTimestamp" : @"endtime",
        @"currentTimestamp" : @"curtime",
        @"shiftTimeInterval" : @"timeshift",
        @"mainUrlString" : @"location",
        @"nodeSubmodels" : @"nodelist",
    }
    LETV_DECLARE_KEYMAPPER_END()
}
@end
