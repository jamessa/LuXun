//
//  LXCoachAndStrategyTestCase.m
//  LuXun-iOS
//
//  Created by jamie on 10/17/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXCoach.h"

@interface LXGoodStrategy : NSObject <LXStrategy>

@end

@implementation LXGoodStrategy

- (NSDictionary *)nextMove {
  return @{@"title":@"好", @"pinyin":@"hao"};
}

@end

@interface LXRandomStragegy : NSObject <LXStrategy>
@end

@interface LXCoachAndStrategyTestCase : XCTestCase {
  LXCoach *coach;
}

@end

@implementation LXCoachAndStrategyTestCase

- (void)setUp
{
  [super setUp];
  coach = [[LXCoach alloc] init];
}

- (void)tearDown
{
  coach = nil;
  [super tearDown];
}

- (void)testDummyCoach
{
  coach.strategy = [[LXGoodStrategy alloc] init];
  XCTAssertTrue([[coach nextMove][@"title"] isEqualToString:@"好"], @"Should always be 好");
}

- (void)testRandomCoach {
  coach.strategy = [[LXRandomStragegy alloc]init];
  NSMutableSet *set = [[NSMutableSet alloc]initWithCapacity:100];
  for (int i=0; i<10; i++) {
    NSString *thisTitle = [coach nextMove][@"title"];
    XCTAssertFalse([set containsObject:thisTitle], @"Should not found");
    [set addObject:thisTitle];
  }
}

@end
