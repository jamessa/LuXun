//
//  LXMemory+Addons.h
//  LuXun-iOS
//
//  Created by jamie on 10/30/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXMemory.h"

@interface LXMemory (Addons)

+ (void) reset; // clear memory
+ (void) fillWithMemories: (NSArray *)memories;
+ (void) sharedMemory;
+ (NSTimeInterval) progressForPinyin: (NSString *)reading;
+ (void) setProgressForPinyin: (NSString *)pinying WithTimeInterval: (NSTimeInterval) timeInterval;

@end
