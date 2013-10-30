//
//  LXCoach.h
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LXStrategy;

@interface LXCoach : NSObject

@property (strong, nonatomic) id<LXStrategy> strategy;

- (void) reset;
- (void) addItems:(NSArray *)items;
- (NSDictionary*) nextMove;
- (void) trackTimeInterval: (NSTimeInterval)timeInterval forPinyin: (NSString *)reading usingContext:(NSManagedObjectContext*)context;

@end

/*
 A strategy has the right to access current progress
 
 Progress is depicted as (reading, 0~1) while stratgy can implment it's own memory data strategy.
 
 A strategy has following
 
 Input:
 Current progress in pairs of (String, -1.0~1.0)
 
 Output:
 A "pinyin" for training
 
 The goal is the achieve all pairs 1.0 in shortest sequence.
 A Strategy has to stored it's own memory.
 
 */
@protocol LXStrategy <NSObject>

@required
- (NSDictionary *) nextMove:(NSArray*)memory;

@end

@interface LXRandomStragegy : NSObject <LXStrategy>


@end