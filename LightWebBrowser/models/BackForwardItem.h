//
//  BackForwardItem.h
//  LightWebBrowser
//
//  Created by 明 on 13-2-28.
//  Copyright (c) 2013年 明. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BackForwardItem : NSObject<NSCoding>
    @property (nonatomic,retain) NSString*title;
    @property (nonatomic,retain) NSString*url;
 
    @property (nonatomic) CGPoint scrollPoint;
    +(BackForwardItem*)fromWebHistoryItem:(id)item;
    -(id)toWebHistoryItem;
@end
