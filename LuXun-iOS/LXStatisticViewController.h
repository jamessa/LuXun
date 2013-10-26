//
//  LXStatisticViewController.h
//  LuXun-iOS
//
//  Created by jamie on 10/25/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXStatisticViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
