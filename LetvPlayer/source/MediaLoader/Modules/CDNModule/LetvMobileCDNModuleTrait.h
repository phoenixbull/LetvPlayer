//
//  LetvMobileCDNModuleTrait.h
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2020/4/10.
//  Copyright © 2020 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LetvMobileCDNModuleTrait <NSObject>
- (RACSignal<NSString*>*) ltrx_parseURLString: (NSString*) urlString;
@end

NS_ASSUME_NONNULL_END
