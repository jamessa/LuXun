//
//  AppDelegate.h
//  LuXun
//
//  Created by jamie on 9/15/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SynchroScrollView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTextViewDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong) IBOutlet NSTextView *inputTextView;
@property (strong) IBOutlet NSTextView *templateTextView;
@property (weak) IBOutlet NSTextFieldCell *hintLabel;
@property (weak) IBOutlet NSTextField *hintTextField;
@property (weak) IBOutlet SynchroScrollView *templateScrollView;
@property (weak) IBOutlet SynchroScrollView *inputScrollView;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
