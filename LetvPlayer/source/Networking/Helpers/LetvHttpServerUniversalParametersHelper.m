//
// Created by Kerberos Zhang on 2018/11/21.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <LetvPlayer/LetvMobileCore.h>
#import "LetvMobileNetworkingContainer.h"
#import "LetvMobileHTTPDefaultGETParametersTrait.h"
#import "LetvHttpServerUniversalParametersHelper.h"


@interface LetvHttpServerUniversalParametersHelper ()
@property (nonatomic, strong, readonly) id<LetvMobileHTTPDefaultGETParametersTrait> injection;
@end

@implementation LetvHttpServerUniversalParametersHelper
- (instancetype) init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (id _Nullable) parametersByParameters: (id _Nullable) parameters error: (NSError* _Nullable __autoreleasing*) error
{
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }

    id newParameters = nil;
    if ([parameters isKindOfClass: [NSDictionary class]]) {
        NSMutableDictionary* mutableDictionary = [(NSMutableDictionary*)parameters mutableCopy];
        NSDictionary* defaultParameters = self.injection.defaultParameters;
        if (defaultParameters) {
            [mutableDictionary addEntriesFromDictionary: defaultParameters];
        }
        newParameters = mutableDictionary;
    }
    return newParameters;
}

#pragma mark -
#pragma mark getter
- (id<LetvMobileHTTPDefaultGETParametersTrait>) injection
{
    id<LetvMobileHTTPDefaultGETParametersTrait> injection = [self.letv_container resolveProtocol: @protocol(LetvMobileHTTPDefaultGETParametersTrait)];
    return injection;
}
@end
