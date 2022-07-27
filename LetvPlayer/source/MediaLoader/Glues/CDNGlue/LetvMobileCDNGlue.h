//
//  LetvMobileCDNGlue.h
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2020/4/10.
//  Copyright © 2020 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "LetvMobileCDNModuleTrait.h"

NS_ASSUME_NONNULL_BEGIN

@interface LetvMobileCDNGlue : NSObject<LetvMobileCDNModuleTrait>

- (RACSignal<NSNumber*>*) ltrx_setup;
- (RACSignal<NSString*>*) ltrx_parseURLString: (NSString* _Nonnull) urlString;
@end

NS_ASSUME_NONNULL_END
