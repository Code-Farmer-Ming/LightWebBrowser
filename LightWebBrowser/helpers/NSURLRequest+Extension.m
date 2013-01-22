//
//  NSURLRequest+Extension.m
//  LightWebBrowser
//
//  Created by 明 on 13-1-16.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "NSURLRequest+Extension.h"

@implementation NSURLRequest (Extension)
//从frame 载入
-(BOOL) isFromFrameLoading
{
    return  ![[[self URL] absoluteString] isEqualToString:[[self mainDocumentURL] absoluteString]];
}
@end
