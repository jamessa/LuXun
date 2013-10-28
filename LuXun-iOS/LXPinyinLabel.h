//
//  LXPinyinLabel.h
//  LuXun-iOS
//
//  Created by jamie on 10/18/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^matchingBlockType)(NSString* reading, NSTimeInterval timeInterval);

@interface LXPinyinLabel : UILabel

@property (strong, nonatomic) NSString *text2;
@property (strong, nonatomic) NSMutableDictionary *characterTimes;
@property (strong, nonatomic) matchingBlockType matchedBlock;

@end
