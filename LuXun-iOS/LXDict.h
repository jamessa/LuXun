//
//  LXDict.h
//  LuXun-iOS
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>

@interface LXDict : NSObject

- (NSArray *) charactersForPinyin:(NSString *)prefix;

- (NSArray *) pinyinReadingForCharacters:(NSString *)characters;

- (NSArray *) random;

- (NSArray *) listAllPinyins;

@end
