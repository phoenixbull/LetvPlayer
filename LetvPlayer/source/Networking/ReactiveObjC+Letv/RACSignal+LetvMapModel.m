//
//  RACSignal+LetvMapModel.m
//  LetvMobileNetworking
//
//  Created by Kerberos Zhang on 2018/11/23.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <JSONModel/JSONModel.h>
#import "LetvMobileCore.h"
#import "LetvMobileModel.h"


@implementation RACSignal (LetvMapModel)
- (RACSignal*) ltrx_mapModel: (Class) modelClass
{
    return [self flattenMap:^ RACSignal * (id  _Nullable responseObject) {
        NSError* error = nil;
        // 空对象.
        if (responseObject == nil) {
            error = LETV_ERROR(LetvErrorCodeEmpty, @"responseObject empty");
            return [RACSignal error: error];
        }
        
        // 乐视服务器不返回非 Dictionary 的数据.
        if (![responseObject isKindOfClass: [NSDictionary class]]) {
            error = LETV_ERROR(LetvErrorCodeJSON, @"responseObject is not dictionary");
            return [RACSignal error: error];
        }
        
        LetvResponseModel* model = [[LetvResponseModel alloc]
                                    initWithDictionary: responseObject
                                    error: &error];
        if (model == nil && error != nil) {
            return [RACSignal error: error];
        }
        
        if (model.header.state != LetvDataStateNormal) {
            NSString* reason = [NSString stringWithFormat: @"Response Header: %ld, errMsg: %@", model.header.state,model.header.error.content];
            error = LETV_ERROR(LetvErrorCodeIllegalData, reason);
            return [RACSignal error: error];
        }
        
        if (model.payload == nil) {
            error = LETV_ERROR(LetvErrorCodeEmpty, @"response body empty");
            return [RACSignal error: error];
        }
        
        if ([model.payload isKindOfClass: [NSDictionary class]]) {
            error = nil;

#if 0
            void *temp = NULL;
            SEL sel = @selector(initWithDictionary:error:);
            id obj = class_createInstance(modelClass, 0);
            NSMethodSignature* signature = [obj methodSignatureForSelector: sel];
            NSInvocation* invocation = [NSInvocation invocationWithMethodSignature: signature];
            invocation.selector = sel;
            NSDictionary* payload = model.payload;
            [invocation setArgument: &payload atIndex: 2];
            [invocation setArgument: &error atIndex: 3];
            [invocation invoke];
            [invocation getReturnValue: &temp];

            id payloadModel = (__bridge id) temp;
#else
            id payloadModel = [[modelClass alloc] initWithDictionary: model.payload
                                                               error: &error];
#endif

            if (payloadModel == nil && error != nil) {
                return [RACSignal error: error];
            }
            
            return [RACSignal return: payloadModel];
        } else if ([model.payload isKindOfClass: [NSArray class]]) {
            NSArray* payloads = (NSArray<NSDictionary*>*)model.payload;
            error = nil;

            void *temp = NULL;
            SEL sel = @selector(arrayOfModelsFromData:error:);
            NSMethodSignature* signature = [modelClass methodSignatureForSelector: sel];
            NSInvocation* invocation = [NSInvocation invocationWithMethodSignature: signature];
            invocation.selector = sel;
            [invocation setArgument: &payloads atIndex: 2];
            [invocation setArgument: &error atIndex: 3];
            [invocation invoke];
            [invocation getReturnValue: &temp];

            NSArray* payloadModels = (__bridge NSArray*) temp;
            /*
            NSArray* payloadModels = [modelClass arrayOfModelsFromDictionaries: payloads error: &error];
            */
            
            if (payloadModels == nil && error != nil) {
                return [RACSignal error: error];
            }
            
            return [RACSignal return: payloadModels];
        }
        
        error = LETV_ERROR(LetvErrorCodeNoError, @"map model error");
        
        return [RACSignal error: error];
    }];
}
@end
