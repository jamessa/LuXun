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
  NSMutableDictionary *readings;

}

- (void)setUp
{
  [super setUp];
  pinyinLabel = [[LXPinyinLabel alloc] init];
  readings = [[NSMutableDictionary alloc] initWithCapacity:5];
}

- (void)tearDown
{
  pinyinLabel = nil;
  readings = nil;
  [super tearDown];
}

- (void)testMatchedBlock {
  
  __block typeof (readings) breadings = readings;
    pinyinLabel.matchedBlock = ^(NSString *reading, NSTimeInterval timeInterval, BOOL isCompleted) {
      if (!isCompleted) {
        [breadings setValue:@(timeInterval) forKey:reading];
      }
  };
  
  pinyinLabel.text = @"háo qì";
  sleep(1); // ensure that leading thinking time is not counted.
  pinyinLabel.text2 = @"h";
  sleep(1);
  pinyinLabel.text2 = @"hao";
  pinyinLabel.text2 = @"hao q";
  sleep(1);
  pinyinLabel.text2 = @"hao qi";
  
  XCTAssertEqualWithAccuracy([readings[@"háo"] doubleValue], 1.0f, 0.1f, @"Should be 1 seconds.");
  XCTAssertEqualWithAccuracy([readings[@"qì"] doubleValue], 1.0f, 0.1f, @"Should be 1 seconds.");
  
}
@end
