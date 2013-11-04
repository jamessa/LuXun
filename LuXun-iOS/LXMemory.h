//
//  LXMemory.h
//  LuXun-iOS
//
//  Created by jamie on 11/4/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LXMemory : NSManagedObject

@property (nonatomic, retain) NSString * reading;
@property (nonatomic) double timeNeeded;
@property (nonatomic) double weight;
@property (nonatomic) int16_t frequencyGroup;

@end
