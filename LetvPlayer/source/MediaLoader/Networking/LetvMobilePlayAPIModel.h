//
//  LetvMobilePlayAPIModel.h
//  LetvMobilePlayerKit
//
//  Created by Kerberos Zhang on 2018/11/14.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


// LETV_MOBILE_CONFIG_USE_DRM: 是否使用 DRM. 香港版本要求视频必须为 DRM 加密过的. 现在已经废弃.


@protocol LetvMobilePlayAPIVideoBitRateModel
@end

@interface LetvMobilePlayAPIVideoBitRateModel : JSONModel
@property (nonatomic, copy) NSString<Optional>* mainUrl;
@property (nonatomic, copy) NSString<Optional>* backUrl0;
@property (nonatomic, copy) NSString<Optional>* backUrl1;
@property (nonatomic, copy) NSString<Optional>* backUrl2;
@property (nonatomic, copy) NSString<Optional>* fileSize;
@property (nonatomic, copy) NSString<Optional>* storePath;
@property (nonatomic, copy) NSString<Optional>* vtype;


@property (nonatomic, copy) NSString<Optional>* token;

#ifdef LETV_MOBILE_CONFIG_USE_DRM
@property (nonatomic, copy) NSString<Optional>* drmToken;
#endif

@property (nonatomic, strong) NSDictionary<Optional>* audioTracks;         // 支持的音轨.
@end


@interface LetvMobilePlayApIVideoRateInfo : JSONModel

@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_180;     // videoFileInfo    视频地址：MP4格式180码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_350;     // videoFileInfo    视频地址：MP4格式350码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_800;     // videoFileInfo    视频地址：MP4格式800码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1000;    // videoFileInfo    视频地址：MP4格式1000码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1300;    // videoFileInfo    视频地址：MP4格式1300码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_720p;    // videoFileInfo    视频地址：MP4格式720p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1080p3m; // videoFileInfo    视频地址：MP4格式1080p码率；

@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_180_marlin;    // videoFileInfo    视频地址：MP4格式720p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_180_access; // videoFileInfo    视频地址：MP4格式1080p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_350_marlin;    // videoFileInfo    视频地址：MP4格式720p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_350_access; // videoFileInfo    视频地址：MP4格式1080p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_800_marlin;    // videoFileInfo    视频地址：MP4格式720p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_1300_access; // videoFileInfo    视频地址：MP4格式1080p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_1300_marlin;    // videoFileInfo    视频地址：MP4格式720p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_800_access; // videoFileInfo    视频地址：MP4格式1080p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_1000_marlin;
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_720p_marlin;
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* drm_1080p3m_marlin;

// 全景视频
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_180_360;     // videoFileInfo    视频地址：MP4格式180码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_350_360;     // videoFileInfo    视频地址：MP4格式350码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_800_360;     // videoFileInfo    视频地址：MP4格式800码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1000_360;    // videoFileInfo    视频地址：MP4格式1000码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1300_360;    // videoFileInfo    视频地址：MP4格式1300码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_720p_360;    // videoFileInfo    视频地址：MP4格式720p码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1080p_360;    // videoFileInfo    视频地址：MP4格式1080p码率；

// 杜比视频
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_800_db;     // videoFileInfo    视频地址：MP4格式180码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1300_db;     // videoFileInfo    视频地址：MP4格式180码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_720p_db;     // videoFileInfo    视频地址：MP4格式180码率；
@property (strong, nonatomic) LetvMobilePlayAPIVideoBitRateModel<Optional>* mp4_1080p6m_db;     // videoFileInfo    视频地址：MP4格式180码率；

- (LetvMobilePlayAPIVideoBitRateModel *)getcurrentRateModel:(NSString *)rate;

@end


@protocol LetvMobilePlayAPIVideoFileModel @end
@interface LetvMobilePlayAPIVideoFileModel : JSONModel
//@property (nonatomic, copy)   NSString* mmid;
@property (nonatomic, copy)   NSString* currentRate;
@property (nonatomic, assign) NSInteger streamErrorCode;
@property (nonatomic, strong) NSArray<NSString*>* supportedRates;
@property (nonatomic, strong) LetvMobilePlayAPIVideoBitRateModel<Optional>* rateModel;
@end


@interface LetvMobilePlayAPIValidateData : JSONModel

@property (nonatomic, strong) NSString<Optional> *status;     //!< 1：代表鉴权通过，0：代表鉴权不通过
@property (nonatomic, strong) NSString<Optional> *token;      //!< 可以播放的token
@property (nonatomic, strong) NSString<Optional> *uid;                 //!< 鉴权使用的uid

//@property (nonatomic, strong) NSString<Optional> *tryTime;             //!< 试看时长

@end

@protocol LetvMobilePlayAPIValidateModel @end
@interface LetvMobilePlayAPIValidateModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *code;
@property (nonatomic, strong) LetvMobilePlayAPIValidateData<Optional> *data;
@end

@interface LetvMobilePlayAPIModel : JSONModel
@property (nonatomic, strong) LetvMobilePlayAPIVideoFileModel<LetvMobilePlayAPIVideoFileModel, Optional>* videoFileModel;
@property (nonatomic, strong)LetvMobilePlayAPIValidateModel<Optional>*validateModel;
@end
