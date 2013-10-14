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

- (FMResultSet*) charactersForPinyin:(NSString *)prefix;

- (FMResultSet*) pinyinReadingForCharacters:(NSString *)characters;

- (FMResultSet*) random;

@end
