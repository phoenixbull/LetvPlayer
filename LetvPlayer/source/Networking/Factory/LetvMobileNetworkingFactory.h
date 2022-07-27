//
// Created by Kerberos Zhang on 2018/11/7.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>
#import <LetvPlayer/LetvMobileHTTPDefaultGETParametersTrait.h>
#import <LetvPlayer/LetvMobileHTTPClientTrait.h>


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileNetworkingFactory : NSObject
LETV_SINGLETON_DECLARE(defaultFactory)
- (id<LetvMobileHTTPClientTrait>) createHTTPClient;

- (id<LetvMobileHTTPClientTrait>) createHTTPClientWithAcceptableContentTypes: (NSArray<NSString*>* _Nullable) acceptableContentTypes;

- (id<LetvMobileHTTPClientTrait>) createHTTPClientWithBaseURLString: (NSString* _Nullable) urlString
                                             acceptableContentTypes: (NSArray<NSString*>* _Nullable) acceptableContentTypes;

- (id<LetvMobileHTTPClientTrait>) createHTTPClientWithBaseURLString: (NSString* _Nullable) urlString
                                                   secondsOfTimeout: (NSInteger) timeout
                                             acceptableContentTypes: (NSArray<NSString*>* _Nullable) acceptableContentTypes
                                               defaultGETParameters: (id<LetvMobileHTTPDefaultGETParametersTrait> _Nullable) defaultParameters
                                                       useSignature: (BOOL) useSignature;

- (id<LetvMobileHTTPClientTrait>) createJSONClientWithBaseURLString: (NSString* _Nullable) urlString
                                                   secondsOfTimeout: (NSInteger) timeout
                                             acceptableContentTypes: (NSArray<NSString*>* _Nullable) acceptableContentTypes
                                               defaultGETParameters: (id<LetvMobileHTTPDefaultGETParametersTrait> _Nullable) defaultParameters
                                                       useSignature: (BOOL) useSignature;
@end
NS_ASSUME_NONNULL_END
