//
//  LetvMobilePlayAPIModel.m
//  LetvMobilePlayerKit
//
//  Created by Kerberos Zhang on 2018/11/14.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import "LetvMobileModels.h"
#import "LetvMobilePlayAPIModel.h"

@implementation LetvMobilePlayAPIVideoBitRateModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"mainUrl"   : @"mainUrl",
      @"backUrl0"  : @"backUrl0",
      @"backUrl1"  : @"backUrl1",
      @"backUrl2"  : @"backUrl2",
      @"fileSize"  : @"filesize",
      @"storePath" : @"storePath",
      }
    LETV_DECLARE_KEYMAPPER_END()
}
@end


@implementation LetvMobilePlayApIVideoRateInfo

- (LetvMobilePlayAPIVideoBitRateModel *)getcurrentRateModel:(NSString *)rate {
    if (rate != nil) {
        if ([rate isEqualToString:@"mp4_180"]) {
            return self.mp4_180;
        }else if([rate isEqualToString:@"mp4_350"]){
            return self.mp4_350;
        }else if([rate isEqualToString:@"mp4_800"]){
            return _mp4_800;
        }else if([rate isEqualToString:@"mp4_720p"]){
            return _mp4_720p;
        }else if([rate isEqualToString:@"mp4_1300"]){
            return self.mp4_1300;
        }else {
            return self.mp4_350;
        }
    }else {
        return self.mp4_350;
    }
}

@end


@implementation LetvMobilePlayAPIValidateData

+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"status"             : @"status",
      @"uid"                : @"uid",
      @"token"              : @"token",
      }
    LETV_DECLARE_KEYMAPPER_END()
}

@end

@implementation LetvMobilePlayAPIValidateModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"code"            : @"code",
      @"data"            : @"data",
      }
    LETV_DECLARE_KEYMAPPER_END()
}

@end

@implementation LetvMobilePlayAPIVideoFileModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"mmid"            : @"mmsid",
      @"currentRate"     : @"currentRate",
      @"streamErrorCode" : @"streamErrCode",
      @"supportedRates"  : @"rateList",
      @"rateModel"       : @"infos",
      }
    LETV_DECLARE_KEYMAPPER_END()
}
@end



@implementation LetvMobilePlayAPIModel
+ (JSONKeyMapper*) keyMapper
{
    LETV_DECLARE_KEYMAPPER_BEGIN()
    @{
      @"videoFileModel"   : @"videofile",
      @"validateModel"   : @"validate",
      }
    LETV_DECLARE_KEYMAPPER_END()
}
@end
