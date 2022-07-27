//
//  NSError+Letv.m
//  LetvMobileCore
//
//  Created by Kerberos Zhang on 2018/11/23.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import "NSError+Letv.h"


const NSErrorDomain LetvErrorDomain = @"com.letv.mobileclient";

NSError* letv_error_new(LetvErrorCode code, NSString* reason, char* file, int line)
{
    return [NSError letv_errorWithCode: code reason: reason file: file line: line];
}

@implementation NSError (Letv)

+ (instancetype) letv_errorWithError: (NSError*) error
{
    if ([error.domain isEqualToString: LetvErrorDomain]) {
        return error;
    } else {
        return [NSError errorWithDomain: LetvErrorDomain
                                   code: LetvErrorCodeGeneric
                               userInfo: error.userInfo];
    }
}

+ (instancetype) letv_errorWithCode: (LetvErrorCode) code reason: (NSString*) reason
{
    return [self letv_errorWithCode: code reason: reason file: NULL line: 0];
}

+ (instancetype) letv_errorWithCode: (LetvErrorCode) code reason: (NSString*) reason file: (char*) file line: (NSInteger) line
{
    NSDictionary* userInfo = ^NSDictionary* {
        NSString* fs = [NSString stringWithCString: file encoding: NSUTF8StringEncoding];
        NSString* ls = [NSString stringWithFormat: @"%ld", line];
        
        if (reason.length == 0 && fs.length == 0 && ls.length == 0) {
            return nil;
        }
        
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity: 3];
        if (reason.length) {
            dict[NSLocalizedDescriptionKey] = reason;
        }
        
        if (fs.length == 0) {
            fs = @"???";
        }
        
        if (ls.length == 0) {
            ls = @"???";
        }
        
        dict[NSFilePathErrorKey] = [NSString stringWithFormat: @"%@@%@", ls, fs];

        return dict;
    }();
    
    NSError* error = [NSError errorWithDomain: LetvErrorDomain
                                         code: code
                                     userInfo: userInfo];
    return error;
    
}
@end
