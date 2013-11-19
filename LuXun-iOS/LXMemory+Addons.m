//
//  LXMemory+Addons.m
//  LuXun-iOS
//
//  Created by jamie on 10/30/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXMemory+Addons.h"
#import "LXAppDelegate.h"

@implementation LXMemory (Addons)

+ (void)reset {
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  
  // Clean
  NSFetchRequest *allMemories = [[NSFetchRequest alloc] init];
  [allMemories setEntity:[NSEntityDescription entityForName:@"Memory" inManagedObjectContext:context]];
  [allMemories setIncludesPropertyValues:NO];
  
  NSError *error = nil;
  NSArray *memories = [context executeFetchRequest:allMemories error:&error];
  
  for (NSManagedObject *memory in memories) {
    [context deleteObject:memory];
  }
  
  NSError *saveError = nil;
  [context save:&saveError];
}

+ (void)fillWithMemories:(NSArray *)memories {
  /* Accumulated count is used here to easily find out reading weight
   
   */
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  
  NSInteger total = [[memories valueForKeyPath:@"@sum.count"] integerValue];
  NSInteger accumulate = 0;
  for (NSDictionary *item in memories) {
    LXMemory *memory = [NSEntityDescription insertNewObjectForEntityForName:@"Memory" inManagedObjectContext:context];
    memory.reading = item[@"pinyin"];
    accumulate += [item[@"count"] doubleValue];
    memory.weight = (double)accumulate/total;
    memory.section = 4 - INT16_C(ceil( memory.weight / 0.25f));
    [context save:nil];
  }
}

+ (void)sharedMemory {
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  
  
}

+ (NSTimeInterval)timeNeededForPinyin:(NSString *)reading {
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  NSManagedObjectModel *model = [[context persistentStoreCoordinator] managedObjectModel];
  NSFetchRequest *fetchAMemory = [model fetchRequestFromTemplateWithName:@"aMemory" substitutionVariables:@{@"READING":reading}];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO];
  
  fetchAMemory.sortDescriptors = @[sortDescriptor];
  
  NSArray *fetchedObjects = [context executeFetchRequest:fetchAMemory error:nil];
  
  if ([fetchedObjects count]==1) {
    return ((LXMemory*)[fetchedObjects objectAtIndex:0]).timeNeeded;
  }
  return 0.0f; // not found.
}

+ (void)setTimeNeeded:(NSTimeInterval)timeNeeded forPinyin:(NSString *)pinyin {
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  NSManagedObjectModel *model = [[context persistentStoreCoordinator] managedObjectModel];
  NSFetchRequest *fetchAMemory = [model fetchRequestFromTemplateWithName:@"aMemory" substitutionVariables:@{@"READING":pinyin}];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO];
  
  fetchAMemory.sortDescriptors = @[sortDescriptor];
  
  NSArray *fetchedObjects = [context executeFetchRequest:fetchAMemory error:nil];
  if ([fetchedObjects count]==0)
    return; // Forget to init memory?
  LXMemory *memory = [fetchedObjects objectAtIndex:0];
  
  if (memory.timeNeeded >= 60.f) {
    memory.timeNeeded = timeNeeded;
  } else {
    memory.timeNeeded = (timeNeeded + memory.timeNeeded) / 2.0;
  }
  
  NSError *error;
  [context save:&error];
  if (error) {
    NSLog(@"Memory save error: %ld, %@", (long)error.code, error.localizedDescription);
  }
  
}

+ (NSString *)leastPracticedPinyinInSection:(NSUInteger)section {
  
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  NSManagedObjectModel *model = [[context persistentStoreCoordinator]managedObjectModel];
  NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"leastPracticedPinyinInSection" substitutionVariables:@{@"SECTION":@0}];
  NSSortDescriptor *byTimeNeeded = [NSSortDescriptor sortDescriptorWithKey:@"timeNeeded" ascending:NO];
  NSSortDescriptor *byWeighting = [NSSortDescriptor sortDescriptorWithKey:@"weight" ascending:NO];
  fetchRequest.fetchLimit = 1;
  fetchRequest.sortDescriptors = @[byTimeNeeded, byWeighting];
  
  NSError *fetchError;
  NSArray *fetchedObjcets = [context executeFetchRequest:fetchRequest error:&fetchError];
  if ([fetchedObjcets count]) {
    return ((LXMemory*)[fetchedObjcets firstObject]).reading;
  }
  
  return nil;
}
@end
