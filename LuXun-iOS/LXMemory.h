//
//  LXMemory.h
//  LuXun-iOS
//
//  Created by jamie on 10/30/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LXMemory : NSManagedObject

@property (nonatomic, retain) NSNumber * progress;
@property (nonatomic, retain) NSString * reading;
@property (nonatomic, retain) NSNumber * weight;

@end
