//
//  AppDelegate.m
//  LuXun
//
//  Created by jamie on 9/15/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreChineseEngine.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  
  [self.inputScrollView setSynchronizeScrollView:self.hintScrollView];
  [self.hintScrollView setSynchronizeScrollView:self.inputScrollView];
  
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.2think.LuXun" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
  return [appSupportURL URLByAppendingPathComponent:@"com.2think.LuXun"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
  if (_managedObjectModel) {
    return _managedObjectModel;
  }
	
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LuXun" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  if (_persistentStoreCoordinator) {
    return _persistentStoreCoordinator;
  }
  
  NSManagedObjectModel *mom = [self managedObjectModel];
  if (!mom) {
    NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
    return nil;
  }
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
  NSError *error = nil;
  
  NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
  
  if (!properties) {
    BOOL ok = NO;
    if ([error code] == NSFileReadNoSuchFileError) {
      ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if (!ok) {
      [[NSApplication sharedApplication] presentError:error];
      return nil;
    }
  } else {
    if (![properties[NSURLIsDirectoryKey] boolValue]) {
      // Customize and localize this error.
      NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
      
      NSMutableDictionary *dict = [NSMutableDictionary dictionary];
      [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
      error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
      
      [[NSApplication sharedApplication] presentError:error];
      return nil;
    }
  }
  
  NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"LuXun.storedata"];
  NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
  if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
    [[NSApplication sharedApplication] presentError:error];
    return nil;
  }
  _persistentStoreCoordinator = coordinator;
  
  return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
  if (_managedObjectContext) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
    [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
    NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    [[NSApplication sharedApplication] presentError:error];
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] init];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  
  return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
  return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
  NSError *error = nil;
  
  if (![[self managedObjectContext] commitEditing]) {
    NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
  }
  
  if (![[self managedObjectContext] save:&error]) {
    [[NSApplication sharedApplication] presentError:error];
  }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
  // Save changes in the application's managed object context before the application terminates.
  
  if (!_managedObjectContext) {
    return NSTerminateNow;
  }
  
  if (![[self managedObjectContext] commitEditing]) {
    NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
    return NSTerminateCancel;
  }
  
  if (![[self managedObjectContext] hasChanges]) {
    return NSTerminateNow;
  }
  
  NSError *error = nil;
  if (![[self managedObjectContext] save:&error]) {
    
    // Customize this code block to include application-specific recovery steps.
    BOOL result = [sender presentError:error];
    if (result) {
      return NSTerminateCancel;
    }
    
    NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
    NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
    NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
    NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:question];
    [alert setInformativeText:info];
    [alert addButtonWithTitle:quitButton];
    [alert addButtonWithTitle:cancelButton];
    
    NSInteger answer = [alert runModal];
    
    if (answer == NSAlertAlternateReturn) {
      return NSTerminateCancel;
    }
  }
  
  return NSTerminateNow;
}


#pragma mark - NSTextView


- (void)textDidChange:(NSNotification *)notification {
  [self.hintTextField setHidden:YES];
  NSRange range = [self.textView selectedRange];
  NSString *text= [self.coachTextView string];
  
  
  if (range.location > text.length-1) {
    [self.hintTextField setHidden:YES];
    return;
  }
  
  NSRange currentRange = (NSRange){range.location,1};
  
  NSString *currentCharacter = [text substringWithRange:currentRange];
 
  
  CIMCharacterInformationRepository *informationRepository;
  
  informationRepository = [[CIMCharacterInformationRepository alloc] initWithScriptType:CIMCharacterInformationRepositoryScriptTypeTraditionalChinese];
  
  NSString *pinyin = [[informationRepository combinedPinyinReadingsForCharacter:currentCharacter]componentsSeparatedByString:@" "][0];
  
//  NSLog(@"Noted location: %lu, selected: %lu is %@ %@", range.location, (unsigned long)range.length, currentCharacter, pinyin);
 
  self.hintLabel.title = pinyin;
  
  if (!pinyin) {
    [self.hintTextField setHidden:YES];
  }
  
  NSUInteger retCount;
  NSRectArray rectArray = [self.textView.layoutManager rectArrayForGlyphRange:range withinSelectedGlyphRange:(NSRange){NSNotFound,0} inTextContainer:self.textView.textContainer rectCount:&retCount];
  
  if (retCount == 0)
    return;
  
  CGRect rect = rectArray[0];
  
  
  CGRect hintFrame = self.hintTextField.frame;
  
  
  hintFrame.origin.x = 46.0 + rectArray[0].origin.x;
  hintFrame.origin.y = 310.0 - rectArray[0].origin.y;
  [self.hintTextField setFrame:hintFrame];
  NSLog(@"Original (%f,%f)", rect.origin.x, rect.origin.y);
  NSLog(@"Converted (%f,%f)", hintFrame.origin.x, hintFrame.origin.y);
  
  
  [self performSelector:@selector(showHint:) withObject:self.hintTextField afterDelay:10];
  
}

- (void)showHint:(id)object {
  [object setHidden:NO];
}

#pragma mark - Scroll View


@end
