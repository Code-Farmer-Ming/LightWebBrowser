//
//  directoryHelper.m
//  LightWebBrowser
//
//  Created by 明 on 13-1-8.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "DirectoryHelper.h"

@implementation DirectoryHelper

+(NSString*) cacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   return [paths lastObject];
}
@end