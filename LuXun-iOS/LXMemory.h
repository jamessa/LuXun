//
//  LXMemory.h
//  LuXun-iOS
//
//  Created by jamie on 11/6/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LXMemory : NSManagedObject

@property (nonatomic) int16_t frequencyGroup;
@property (nonatomic, retain) NSString * reading;
@property (nonatomic) double timeNeeded;
@property (nonatomic) double weight;
@property (nonatomic) int16_t section;

@end
