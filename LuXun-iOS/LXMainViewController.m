//
//  LXMainViewController.m
//  LuXun-iOS
//
//  Created by jamie on 10/13/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXMainViewController.h"
#import "LXCoach.h"
#import "LXDict.h"
#import "NSString+LuXun.h"
#import "LXPinyinLabel.h"
#import "LXStatisticViewController.h"

@interface LXMainViewController () <UITextViewDelegate> {
  LXCoach *coach;
}

@property (weak, nonatomic) IBOutlet UILabel *helperLabel;
@property (weak, nonatomic) IBOutlet LXPinyinLabel *pinyinLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation LXMainViewController

#pragma mark - This Controller only

- (void)nextTrial {
  NSDictionary *coachCharacters = [coach nextMove];
  self.helperLabel.text = coachCharacters[@"title"];
  self.pinyinLabel.text = coachCharacters[@"pinyin"];
  self.inputTextView.text = @"";
}

#pragma mark - ViewController Delegate

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.inputTextView becomeFirstResponder];
  [self nextTrial];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
 if (!coach) {
    coach = [[LXCoach alloc] init];
  }
  
  self.pinyinLabel.matchedBlock = ^(NSString *reading, NSTimeInterval timeInterval) {
    [coach trackTimeInterval: timeInterval forPinyin: reading usingContext:self.managedObjectContext];
  };
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - `Flipside View

- (void)flipsideViewControllerDidFinish:(LXFlipsideViewController *)controller
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"showStatistic"]) {
    [(LXStatisticViewController *)[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
  }
}

#pragma mark - StatisticViewController


#pragma mark - UITextFieldDelegate

- (void)textViewDidChange:(UITextView *)textView {
  
  if ([self.helperLabel.text isEqualToString:textView.text]) {
    // some bingo animation here.
    [self nextTrial];
  }
  
  self.pinyinLabel.text2 = textView.text;
  
}
@end
