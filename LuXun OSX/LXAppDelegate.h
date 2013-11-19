//
//  LXAppDelegate.h
//  LuXun OSX
//
//  Created by jamie on 11/19/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LXAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
