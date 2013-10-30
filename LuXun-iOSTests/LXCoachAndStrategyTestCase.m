//
//  LXCoachAndStrategyTestCase.m
//  LuXun-iOS
//
//  Created by jamie on 10/17/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXCoach.h"
#import "LXAppDelegate.h"
#import "LXMemory.h"
#import "LXDict.h"

@interface LXGoodStrategy : NSObject <LXStrategy>

@end

@implementation LXGoodStrategy

- (NSDictionary *)nextMove:(NSArray*)memory {
  return @{@"title":@"好", @"pinyin":@"hao"};
}

@end

@interface LXCoachAndStrategyTestCase : XCTestCase {
  LXCoach *coach;
}

@end

@implementation LXCoachAndStrategyTestCase {
  NSManagedObjectContext *context;
}

- (void)setUp
{
  [super setUp];
  coach = [[LXCoach alloc] init];
  context = ((LXAppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

- (void)tearDown
{
  coach = nil;
  context = nil;
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

- (void)testRandomStrategyWithUniMemory {
  [coach addItems:@[@{@"hào":@0.5f}]];
  NSDictionary *next = [coach nextMove];
  XCTAssertEqualObjects(@"hào", next[@"pinyin"], @"Should be the same.");
  
}

//- (void)testInitMemory {
//  NSDictionary *dict = @{@"hà0", @0.0f,
//                         @"há0", @0.1f};
//  LXCoach *coachWithLimitedMemory = [[LXCoach alloc] initWithMemory: dict];
//}

- (void)testInitMemory {
  /*
   test if memory is empty
   create initial memory
   */
  
  [coach reset];
  
  NSManagedObjectModel *model = [[context persistentStoreCoordinator] managedObjectModel];
  
  NSFetchRequest *fetchAll = [model fetchRequestFromTemplateWithName:@"allMemories" substitutionVariables:nil];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"progress" ascending:NO];
  
  [fetchAll setSortDescriptors:@[sortDescriptor]];
  
  NSArray *fetchedObject = [context executeFetchRequest:fetchAll error:nil];
  
  XCTAssertTrue([[fetchedObject valueForKeyPath:@"@count.reading"] integerValue] == (NSUInteger)1421, @"Should be 1421.");
  LXMemory *firstMemory = [fetchedObject objectAtIndex:0];
  XCTAssertEqualWithAccuracy([firstMemory.weight doubleValue], 1.0f, 0.000001f, @"Weight max should be 1.");
  
}

@end
