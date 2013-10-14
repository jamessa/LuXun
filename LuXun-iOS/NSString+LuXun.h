//
//  NSString+LuXun.h
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LuXun)

- (NSRange) rangeOfLongestMatchingSinceBeginning: (NSString*) characters;

@end
