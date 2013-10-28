//
//  LXHistory+LXHistory_Addons.m
//  LuXun-iOS
//
//  Created by jamie on 10/28/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXHistory+Addons.h"

@implementation LXHistory (Addons)

+ (void)trackTimeInterval:(NSTimeInterval)timeInterval forReading:(NSString *)reading withContext:(NSManagedObjectContext *)context {
  
  LXHistory *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
  history.timestamp = [NSDate date];
  history.reading = reading;
  history.responseTime = @(timeInterval);
  [context save:nil];
}
@end
