//
//  LuXun_iOSTests.m
//  LuXun-iOSTests
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>

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

@end
