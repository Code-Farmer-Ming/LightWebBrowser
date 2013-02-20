//
//  NSString+toMD5.m
//  LightWebBrowser
//
//  Created by 明 on 13-1-8.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "NSString+toMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (toMD5)
-(NSString *)toMD5
{
    const char *src = [[self lowercaseString] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, strlen(src), result);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", result[i]];
      return  output;
}

-(BOOL)isURL
{
    NSString *urlRegEx =  @"(http(s)?://|)([\\w-]+\\.)+[\\w-]{2,}([\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}
@end
