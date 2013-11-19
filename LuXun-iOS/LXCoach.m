//
//  LXCoach.m
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXCoach.h"
#import "LXDict.h"
#import "LXHistory+Addons.h"
#import "LXMemory+Addons.h"

@implementation LXRandomStragegy {
  LXDict *dictionary;
}

- (id)init {
  self = [super init];
  if (!self)
    return nil;
  
  dictionary = [[LXDict alloc] init];
  return self;
}

- (NSDictionary *)nextMove:(NSArray*)memory {
  if([memory count]){
    return @{@"pinyin":@"hào"};
  }
  
  NSArray *array = [dictionary random];
  return [array objectAtIndex:(rand()%[array count])];
}

@end

@implementation LXThreePhaseStrategy {
  LXDict *dictionary;
}

- (id)init {
  self = [super init];
  if (!self)
    return nil;
  
  dictionary = [[LXDict alloc] init];
  return self;
}


- (NSDictionary *)nextMove:(NSArray *)memory{
  NSString *pinyin = [LXMemory leastPracticedPinyinInSection:1];
  return [dictionary randomCharactersForPinyin:pinyin];
}


@end

@implementation LXCoach {
  NSMutableArray *memory;
}

- (id)init {
  self = [super init];
  if (!self)
    return nil;
  
  // default strategy
  self.strategy = [[LXRandomStragegy alloc] init];
  memory = [@[] mutableCopy];
  return self;
}

- (void) reset {
  [LXMemory reset];
  
  LXDict *dict = [[LXDict alloc] init];
  [LXMemory fillWithMemories:[dict listAllPinyins]];
}

- (void)addItems:(NSArray *)items {
  [memory addObjectsFromArray:items];
}

- (NSDictionary *)nextMove{
  return [self.strategy nextMove:memory];
}

- (void)trackTimeInterval:(NSTimeInterval)timeInterval forPinyin:(NSString *)reading usingContext:(NSManagedObjectContext *)context {
  [LXHistory trackTimeInterval:timeInterval forReading:reading withContext:context];
  [LXMemory setTimeNeeded:timeInterval forPinyin:reading];
}
@end
