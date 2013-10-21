//
//  LXPinyinLabeTestCase.m
//  LuXun-iOS
//
//  Created by jamie on 10/18/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXPinyinLabel.h"

@interface LXPinyinLabeTestCase : XCTestCase

@end

@implementation LXPinyinLabeTestCase {
  LXPinyinLabel *pinyinLabel;
}

- (void)setUp
{
  [super setUp];
  pinyinLabel = [[LXPinyinLabel alloc] init];
}

- (void)tearDown
{
  pinyinLabel = nil;
  [super tearDown];
}

- (void)testMatching{
  pinyinLabel.text = @"hao";
  pinyinLabel.text2 = @"hb";
  
}

- (void)testTiming {
  pinyinLabel.text = @"háo qì";
  pinyinLabel.text2 = @"h";
  sleep(1);
  pinyinLabel.text2 = @"hao";
  pinyinLabel.text2 = @"hao q";
  sleep(1);
  pinyinLabel.text2 = @"hao qi";
  
  XCTAssertEqualWithAccuracy([pinyinLabel.characterTimes[@"háo"]doubleValue], 1.0, 0.1, @"Should be 1 seconds.");
  XCTAssertEqualWithAccuracy([pinyinLabel.characterTimes[@"qì"]doubleValue], 1.0, 0.1, @"Should be 1 seconds.");
}
@end
