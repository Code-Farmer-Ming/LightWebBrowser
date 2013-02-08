//
//  LightWebView.h
//  LightWebBrowser
//
//  Created by 明 on 12-12-26.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebBackForwardList.h"

@interface LightWebView : UIWebView


- (void)scrollToTop;

-(UIImage*)captureScreen;

-(NSString *) saveCaptureToCacheFile;

-(NSString *) captureFilePath;
-(NSString *) captureFilePath: (NSString*)fileName;

-(void)loadRequestFromString: (NSString*)urlString;
- (WebBackForwardList*) backForwardList;
@end
