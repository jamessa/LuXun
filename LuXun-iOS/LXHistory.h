//
//  LXHistory.h
//  LuXun-iOS
//
//  Created by jamie on 10/24/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LXHistory : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * reading;
@property (nonatomic, retain) NSNumber * responseTime;

@end
