//
//  HistoryItem.h
//  LightWebBrowser
//
//  Created by 明 on 13-2-17.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryItem : NSManagedObject

@property (nonatomic, retain) NSDate * lastVisitedDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * urlMd5;

@end
