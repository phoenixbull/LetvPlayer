//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//

// TODO: using private function
#import "NSString+LetvMD5.h"
#import "LetvHttpServerAPISignatureHelper.h"


static const NSString* privateKey = @"VTl0Rw6toFRiyE*hw98WYj&avSjFQN@&";


@implementation LetvHttpServerAPISignatureHelper
LETV_SINGLETON_IMPL(defaultHelper)

- (NSURLRequest*) requestBySigningRequest: (NSURLRequest*) request
                                    error: (NSError* _Nullable __autoreleasing*) error
{
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL: request.URL resolvingAgainstBaseURL: NO];

    NSString* token = [self tokenWithPrivateKey: privateKey
            timestamp: (NSUInteger)[[NSDate date] timeIntervalSince1970]
                                     queryItems: urlComponents.queryItems];

    NSMutableURLRequest* mutableRequest = [request mutableCopy];
    if (token.length) {
        [mutableRequest setValue: token forHTTPHeaderField: @"TK"];
        *error = nil;
    }

    return mutableRequest;
}

- (NSString*) tokenWithPrivateKey: (const NSString*) privateKey
                        timestamp: (NSUInteger) timestamp
                       queryItems: (NSArray<NSURLQueryItem*>*) queryItems
{
    NSArray<NSURLQueryItem*>* sortedQueryItems = [queryItems sortedArrayUsingComparator: ^NSComparisonResult(NSURLQueryItem* q1, NSURLQueryItem* q2) {
        return [q1.name compare: q2.name];
    }];

    NSString* queryString = [[sortedQueryItems letv_mapObjectsUsingBlock:^id(NSURLQueryItem *q, NSUInteger index) {
        return [NSString stringWithFormat:@"%@=%@", q.name, q.value];
    }] componentsJoinedByString: @"&"];

    if (queryString.length == 0) {
        queryString = @"";
    }
    
    NSString* md5 = [[NSString stringWithFormat:@"%@%zd%@", privateKey, timestamp, queryString] letv_md5HexDigest];

    NSString* token = [NSString stringWithFormat: @"%@.%zd", md5, timestamp];

    return token;
}
@end
