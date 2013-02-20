//
//  HistoryItem+extension.m
//  LightWebBrowser
//
//  Created by 明 on 13-2-17.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "HistoryItem+extension.h"
#import "NSString+toMD5.h"

@implementation HistoryItem (extension)

-(HistoryItem*)initWithTitle:(NSString *)title url:(NSString *)url manageObjectContext:(NSManagedObjectContext *)manageObjectContext
{
  
    HistoryItem *history = [NSEntityDescription
                                      insertNewObjectForEntityForName:NSStringFromClass([self class])
                                      inManagedObjectContext:manageObjectContext];
    history.title = title;
    history.url = url;
    history.lastVisitedDate =  [NSDate date];
    history.urlMd5 = [url toMD5];
    NSError *error;
    if (![manageObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    return  history;
}
+(NSArray*) seachByTitleOrUrl:(NSString *)titleOrUrl manageObjectContext:(NSManagedObjectContext*) context
{
    NSError *error;
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HistoryItem"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    return [context executeFetchRequest:fetchRequest error:&error];
}
@end
