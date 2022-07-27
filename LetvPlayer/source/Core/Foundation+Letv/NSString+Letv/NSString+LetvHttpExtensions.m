//
//  NSString+LetvHttpExtensions.m
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2020/4/13.
//  Copyright © 2020 Letv. All rights reserved.
//

#import "NSString+LetvHttpExtensions.h"


@implementation NSString (LetvHttpExtensions)

+ (NSString *)letv_replaceString:(NSString *)originURL keyword:(NSString *)keyword toValue:(NSString *)toValue {
    if ([NSString letv_empty:keyword] || [NSString letv_empty:toValue]) {
        return originURL;
    }


    NSString *keywordTemp = [NSString stringWithFormat:@"%@=", keyword];

    NSArray *array =[originURL componentsSeparatedByString:@"&"];
    if (array.count <= 0) {
        return originURL;
    }

    BOOL isFound = NO;

    for (NSString *str in array) {
        NSRange range = [str rangeOfString:keywordTemp];
        if (range.location != NSNotFound) {
            NSString *tarStr =[NSString stringWithFormat:@"%@%@", keywordTemp, toValue];
            originURL =[originURL stringByReplacingOccurrencesOfString:str withString:tarStr];
            isFound = YES;
            break;
        }
    }

    if (!isFound){
        originURL = [originURL stringByAppendingFormat:@"&%@%@", keywordTemp, toValue];
    }

    return originURL;
}


+ (BOOL)letv_empty:(NSObject *)o{
    if (o==nil) {
        return YES;
    }
    if (o==NULL) {
        return YES;
    }
    if (o==[NSNull new]) {
        return YES;
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [NSString letv_isBlankString:(NSString *)o];
    }
    if ([o isKindOfClass:[NSData class]]) {
        return [((NSData *)o) length]<=0;
    }
    if ([o isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSArray class]]) {
        return [((NSArray *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSSet class]]) {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}


+ (BOOL)letv_isBlankString:(NSString *)string{

    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if (    [string isEqual:nil]
            ||  [string isEqual:Nil]){
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [string length]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }

    return NO;

}


+ (NSString*)letv_safeString:(NSString*)srcStr{

    if ([NSString letv_empty:srcStr]) {
        return @"";
    }

    return [NSString stringWithFormat:@"%@", srcStr];

}


@end
