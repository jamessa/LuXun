//
//  LXDict.m
//  LuXun-iOS
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXDict.h"

@implementation LXDict {
  FMDatabase *database;
}

- (id)init {
  self = [super init];
  
  if (!self)
    return nil;

  NSString *pathToDB = [[NSBundle mainBundle] pathForResource:@"dict-revised" ofType:@"sqlite3"];
  database = [FMDatabase databaseWithPath:pathToDB];
  
  if (!database) {
    NSLog(@"Database open failed: (%d) %@", [database lastErrorCode], [database lastErrorMessage]);
  }
  
  [database open];
  return self;
}

- (NSArray *)executeQuery:(NSString*) queryString {
  FMResultSet *s = [database executeQuery:queryString];
  
  if (!s) {
    NSLog(@"Query failed: (%d) %@", [database lastErrorCode], [database lastErrorMessage]);
  }
  
  NSMutableArray *returningArray = [[NSMutableArray alloc] init];
  
  while ([s next]) {
    [returningArray addObject:s.resultDictionary];
  }
  
  [s close];
  return returningArray;
}

- (NSArray *)charactersForPinyin:(NSString *)prefix {
  
  NSString *queryString = [NSString stringWithFormat:@"select entries.title, heteronyms.pinyin from heteronyms inner join entries on entries.id = heteronyms.entry_id where heteronyms.pinyin like '%@' order by length(title) limit 10", prefix];
  return [self executeQuery:queryString];

}

- (NSArray *)pinyinReadingForCharacters:(NSString *)characters {
  NSString *queryString = [NSString stringWithFormat:@"select entries.title, heteronyms.pinyin from heteronyms inner join entries on entries.id = heteronyms.entry_id where title like '%@' order by pinyin limit 5",characters];
  
  return [self executeQuery:queryString];

}

- (NSArray *)random {
  NSString *queryString = @"select entries.title, heteronyms.pinyin from heteronyms inner join entries on entries.id = heteronyms.entry_id where ( entries.id = (abs(random()) % (select max(rowid)+1 from entries)) )";
  
  return [self executeQuery:queryString];
  
}

- (NSArray *)listAllPinyins {
  return [self executeQuery:@"select * from pinyins order by count ASC;"];
}
@end
