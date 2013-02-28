//
//  HistoryItem+extension.h
//  LightWebBrowser
//
//  Created by 明 on 13-2-17.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "HistoryItem.h"

@interface HistoryItem (extension)

-(HistoryItem*) initWithTitle:(NSString*)title url:(NSString*)url manageObjectContext:(NSManagedObjectContext*)manageObjectContext;
+(NSArray*) seachByTitleOrUrl:(NSString*) titleOrUrl manageObjectContext:(NSManagedObjectContext*) context;
+(void) createWithTitle:(NSString*)title url:(NSString*)url manageObjectContext:(NSManagedObjectContext*)manageObjectContext;
@end
