//
//  HDAppDelegate.h
//  HotDaily
//
//  Created by weizhou on 7/2/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@interface HDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
