//
//  XCStringTestCase.m
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+LuXun.h"

@interface XCStringTestCase : XCTestCase

@end

@implementation XCStringTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testFindLongestMatchedReading {
  
  NSString *pinyinString = @"xùn fú";
  XCTAssertEqual([pinyinString rangeOfLongestMatchingSinceBeginning:@"xun fu"].length, (NSUInteger)6, @"Six character should be matched.");
  XCTAssertEqual([pinyinString rangeOfLongestMatchingSinceBeginning:@"xum"].length, (NSUInteger)2, @"Two character should be matched");
  XCTAssertEqual([pinyinString rangeOfLongestMatchingSinceBeginning:@"g"].length, (NSUInteger)0, @"Zero character should be matched");
  XCTAssertEqual([pinyinString rangeOfLongestMatchingSinceBeginning:@"xun\u2006fu"].length, (NSUInteger)6, @"Six character should be matched.");
  
  // lǜ -> lv
  NSString *greenPinyin = @"lǜ";
  XCTAssertEqual([greenPinyin rangeOfLongestMatchingSinceBeginning:@"lv"].length, (NSUInteger)2, @"Two character should be matched.");
  NSString *anotherPinyin = @"lü";
  XCTAssertEqual([anotherPinyin rangeOfLongestMatchingSinceBeginning:@"lv"].length, (NSUInteger)2, @"Two character should be matched.");
  
  NSString *huantengPinyin = @"huān téng";
  XCTAssertEqual([huantengPinyin rangeOfLongestMatchingSinceBeginning:@"huan teng"].length, (NSUInteger)9, @"Nine characters should be matched.");
}

@end
