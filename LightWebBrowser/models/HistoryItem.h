//
//  HistoryItem.h
//  LightWebBrowser
//
//  Created by 明 on 13-1-17.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryItem : NSObject
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* title;
 
@property (nonatomic) NSTimeInterval  lastVisitedTimeInterval;
  
@end
