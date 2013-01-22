//
//  UIView+Extension.m
//  LightWebBrowser
//
//  Created by 明 on 13-1-16.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
//显示到前面
-(void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}
@end
