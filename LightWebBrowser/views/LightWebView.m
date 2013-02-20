//
//  LightWebView.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-26.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "LightWebView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+toMD5.h"
#import "DirectoryHelper.h"
#import "WebBackForwardList.h"

@implementation LightWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (WebBackForwardList*) backForwardList
{
    return [[[self performSelector:@selector(_documentView)] performSelector:@selector(webView)] performSelector:@selector(backForwardList)];
}
-(void)scrollToTop
{
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
}

-(UIImage*)captureScreen{
    if (UIGraphicsGetCurrentContext()) {
        UIGraphicsBeginImageContext(self.bounds.size);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return viewImage;

    }
    else
        return nil;
   }

-(NSString *)saveCaptureToCacheFile
{
    NSString* cacheFilePath = self.captureFilePath;
    NSLog(@"captureFile %@",cacheFilePath);
    NSData* imageData = UIImagePNGRepresentation(self.captureScreen);
    [imageData writeToFile:cacheFilePath atomically:YES];
    return cacheFilePath;
}

-(NSString *) captureFilePath
{
  return [self captureFilePath: [[[self.request URL] absoluteString] toMD5] ]  ;
}
-(NSString *) captureFilePath: (NSString*)fileName
{
    return [DirectoryHelper cacheFilePathName:fileName]  ;
}
 
-(void)loadRequestFromString: (NSString*)urlString
{
    NSURL *url = [NSURL URLWithString: urlString];
    if (!url.scheme)
    {
        NSString* modifiedURLString = [NSString stringWithFormat:@"http://%@", urlString];
        url = [NSURL URLWithString:modifiedURLString];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self loadRequest:urlRequest];
}

-(NSString*) title
{
    return  [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}
-(NSString*) url
{
    return  [[[self request] URL] absoluteString];
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
