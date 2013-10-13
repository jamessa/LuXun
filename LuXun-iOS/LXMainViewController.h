//
//  LXMainViewController.h
//  LuXun-iOS
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface LXMainViewController : UIViewController <LXFlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
