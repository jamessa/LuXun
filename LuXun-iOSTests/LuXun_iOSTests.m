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

- (void)testExample
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"PinyinToZhuyin" ofType:@"plist"];
  
  NSData *plistData = [NSData dataWithContentsOfFile:path];
  NSString *error;
  NSPropertyListFormat format;
  id plist;
  
  plist = [NSPropertyListSerialization propertyListFromData:plistData
                                            mutabilityOption:NSPropertyListImmutable
                                                      format:&format
                                            errorDescription:&error];
  NSLog(@"%@", [plist class]);
}

- (void)testDictionary {
  
  LXDict *dict = [[LXDict alloc] init];
  FMResultSet *s = [dict charactersForPinyin:@"gǎo %"];
  [s next];
  XCTAssertTrue([s.resultDictionary[@"title"] isEqualToString:@"搞丟"], @"should be 搞丟");
  [s close];
  s = [dict charactersForPinyin:@"hǎo %"];
  [s next];
  XCTAssertTrue([s.resultDictionary[@"title"] isEqualToString:@"好不"], @"the first bi-gram should be 好不");
  
  
  s = [dict pinyinReadingForCharacters:@"好"];
  [s next];
  XCTAssertTrue([s.resultDictionary[@"pinyin"] isEqualToString:@"hào" ], @"should be hào");
  [s next];
  XCTAssertTrue([s.resultDictionary[@"pinyin"] isEqualToString:@"hǎo"], @"should be hǎo");
}

- (void)testCoach {
  LXCoach *coach = [[LXCoach alloc] init];
  NSString *nextQuestion = [coach nextMove];
  XCTAssertNotNil(nextQuestion, @"Should have next move");
  
  // should be able to run many times.
  for (int i=0; i<=1000; i++) {
    [coach nextMove];
  }
}

@end
