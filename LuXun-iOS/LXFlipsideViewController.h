//
//  LXFlipsideViewController.h
//  LuXun-iOS
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXFlipsideViewController;

@protocol LXFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(LXFlipsideViewController *)controller;
@end

@interface LXFlipsideViewController : UIViewController

@property (weak, nonatomic) id <LXFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
