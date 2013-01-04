//
//  LightWebView.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-26.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "LightWebView.h"
#import <QuartzCore/QuartzCore.h>

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

-(UIImage*)captureScreen{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

 
- (UIWebView *)webView:(UIWebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
    
    return sender;
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
