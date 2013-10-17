//
//  LXCoach.m
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXCoach.h"
#import "LXDict.h"

@interface LXRandomStragegy : NSObject <LXStrategy>


@end

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

- (NSDictionary *)nextMove {
  NSArray *array = [dictionary random];
  return [array objectAtIndex:(rand()%[array count])];
}

@end

@implementation LXCoach {
}

- (id)init {
  self = [super init];
  if (!self)
    return nil;
  
  // default strategy
  self.strategy = [[LXRandomStragegy alloc] init];
  return self;
}

- (NSDictionary *)nextMove{
  return [self.strategy nextMove];
}

- (void)track:(NSDictionary *)currentCharacter pinyinTime:(float)time1 hanziTime:(float)time2 {
  NSLog(@"%@ %f %f", currentCharacter[@"title"], time1, time2);
}
@end
