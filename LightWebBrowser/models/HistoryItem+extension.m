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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url CONTAINS  %@ or title CONTAINS  %@",
                              titleOrUrl,titleOrUrl];
 
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HistoryItem"
                                              inManagedObjectContext:context];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:5];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"lastVisitedDate" ascending:NO];
    
    NSDictionary *properties = [entity propertiesByName];
    fetchRequest.propertiesToFetch = [NSArray arrayWithObjects:[properties objectForKey:@"url"], [properties objectForKey:@"title"], nil];
    fetchRequest.returnsDistinctResults = YES;
    fetchRequest.resultType = NSDictionaryResultType;
    
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor,nil] ;

    [fetchRequest setSortDescriptors:sortDescriptors];
    return [context executeFetchRequest:fetchRequest error:&error];
}

+(void)createWithTitle:(NSString *)title url:(NSString *)url manageObjectContext:(NSManagedObjectContext *)manageObjectContext
{
       [[HistoryItem alloc] initWithTitle: title url:url  manageObjectContext:manageObjectContext];
}
@end
