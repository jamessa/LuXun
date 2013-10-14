//
//  LXCoach.m
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXCoach.h"
#import "LXDict.h"


@implementation LXCoach {
  LXDict *dictionary;
  NSArray *trainingSet;
  NSUInteger trainingSetIndex;
}

- (id)init {
  self = [super init];
  if (!self)
    return nil;
  
  dictionary = [[LXDict alloc] init];
  trainingSet = @[@"八",@"趴",@"嗎",@"發"];
  trainingSetIndex = 0;
  return self;
}

- (NSDictionary *)nextMove{
//  return [trainingSet objectAtIndex:trainingSetIndex++%[trainingSet count]];
  NSArray *array = [dictionary random];
  return [array firstObject];
}

@end
