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
  NSManagedObjectContext *context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  
  double weightMAX = 0;
  for (NSDictionary *item in memories) {
    
    LXMemory *memory = [NSEntityDescription insertNewObjectForEntityForName:@"Memory" inManagedObjectContext:context];
    memory.reading = item[@"pinyin"];
    
    if (weightMAX == 0) {
      weightMAX = [item[@"count"] doubleValue];
    }
    
    memory.weight = @([item[@"count"] doubleValue]/weightMAX);
    [context save:nil];
  }
}
@end
