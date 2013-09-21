//
//  LuXunTests.m
//  LuXunTests
//
//  Created by jamie on 9/15/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreChineseEngine.h"

@interface LuXunTests : XCTestCase

@end

@implementation LuXunTests

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
  
  NSString *aString = @"節省時間，也就是使一個人的有限的生命更加有效";
  NSString *aCharacter = @"一";
  CIMCharacterInformationRepository *informationRepository;
  informationRepository = [[CIMCharacterInformationRepository alloc] initWithScriptType:CIMCharacterInformationRepositoryScriptTypeTraditionalChinese];
  
  NSLog(@"%@ Pinyin", [informationRepository combinedPinyinReadingsForCharacter:aCharacter]);
  NSLog(@"%@ Zhuyin", [informationRepository combinedZhuyinReadingsForCharacter:aCharacter]);
  NSLog(@"%@ striped", [[informationRepository combinedPinyinReadingsForCharacter:aCharacter] stringByStrippingDiacritics]);
  NSDictionary *dict = [informationRepository pinyinReadingsForCharacters:aString];
  NSLog(@"%@ pinyinReadings", dict[@"節"][0]);
//  NSLog(@"%@", [informationRepository pinyinReadingsForCharacters:aString]);
}

@end
