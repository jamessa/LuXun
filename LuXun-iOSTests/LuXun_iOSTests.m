//
//  LuXun_iOSTests.m
//  LuXun-iOSTests
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXDict.h"
#import <FMDatabase.h>
#import "LXCoach.h"

@interface LuXun_iOSTests : XCTestCase

@end

@implementation LuXun_iOSTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDictionary {
  
  LXDict *dict = [[LXDict alloc] init];
  
  NSArray *gao = [dict charactersForPinyin:@"gǎo"];
  XCTAssertEqualObjects(gao[0][@"title"], @"搞", @"Should be 搞");
  NSArray *hao = [dict charactersForPinyin:@"hǎo"];
  XCTAssertEqualObjects(hao[0][@"title"],@"好", @"should be 好");
 
  NSArray *pinyinForHao = [dict pinyinReadingForCharacters:@"好"];
  XCTAssertEqualObjects(pinyinForHao[0][@"pinyin"], @"hào", @"Should be hào");
  XCTAssertEqualObjects(pinyinForHao[1][@"pinyin"], @"hǎo", @"Should be hǎo");
}

- (void)testCoach {
  LXCoach *coach = [[LXCoach alloc] init];
  
  // should be able to run many times in a short time
  for (int i=0; i<=100; i++) {
    NSDictionary *currentPlay = [coach nextMove];
    XCTAssertTrue([currentPlay objectForKey:@"title"], @"should have title");
    XCTAssertTrue([currentPlay objectForKey:@"pinyin"], @"should have pinyin");
  }
}

@end
