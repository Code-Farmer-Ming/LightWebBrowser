//
//  ASTONAppDelegate.h
//  LightWebBrowser
//
//  Created by 明 on 12-12-19.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTONAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
