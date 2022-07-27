//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <CommonCrypto/CommonDigest.h>
#import "NSData+LetvMD5.h"


@implementation NSData (LetvMD5)
- (NSString*)letv_md5HexDigest
{
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    memset(digest, 0, sizeof(digest) / sizeof(unsigned char));

    const char* bytes = self.bytes;
    CC_MD5(bytes, (CC_LONG)self.length, digest);

    NSMutableString *digestString = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [digestString appendFormat: @"%02x", digest[i]];
    }

    return digestString;
}
@end