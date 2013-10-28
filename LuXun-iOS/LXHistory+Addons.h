//
//  LXHistory+LXHistory_Addons.h
//  LuXun-iOS
//
//  Created by jamie on 10/28/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXHistory.h"

@interface LXHistory (Addons)

+ (void) trackTimeInterval: (NSTimeInterval) timeInterval forReading: (NSString*)reading withContext:(NSManagedObjectContext*)context;

@end
