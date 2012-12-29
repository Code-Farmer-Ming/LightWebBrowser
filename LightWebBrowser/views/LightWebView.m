//
//  LightWebView.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-26.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "LightWebView.h"

@implementation LightWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)scrollToTop
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
