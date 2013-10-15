//
//  NSString+LuXun.m
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "NSString+LuXun.h"

@implementation NSString (LuXun)

- (NSRange)rangeOfLongestMatchingSinceBeginning:(NSString *)characters {
  NSString *normalizeString = [self stringByFoldingWithOptions:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch locale:nil];
  
  NSUInteger i;
  for (i=0; i<MIN([normalizeString length],[characters length]); i++){
    // Special Case for Six-Per-Em Space http://en.wikipedia.org/wiki/Space_(punctuation)
    if ([characters characterAtIndex:i]==0x2006 && [normalizeString characterAtIndex:i]==0x20)
      continue;
    
    if ([normalizeString characterAtIndex:i] != [characters characterAtIndex:i])
      break;
  }
  
  return (NSRange){0,i};
}

@end
