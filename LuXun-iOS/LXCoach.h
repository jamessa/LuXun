//
//  LXCoach.h
//  LuXun-iOS
//
//  Created by jamie on 10/14/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCoach : NSObject

- (NSDictionary*) nextMove;
- (void) track:(NSDictionary*)currentCharacter pinyinTime:(float)time1 hanziTime:(float)time2;

@end
