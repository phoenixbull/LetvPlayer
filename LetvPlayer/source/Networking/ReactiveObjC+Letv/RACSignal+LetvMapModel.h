//
//  RACSignal+LetvMapModel.h
//  LetvMobileNetworking
//
//  Created by Kerberos Zhang on 2018/11/23.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN
@interface RACSignal<__covariant ValueType> (LetvMapModel)
- (RACSignal<ValueType>*) ltrx_mapModel: (Class) modelClass;
@end
NS_ASSUME_NONNULL_END
