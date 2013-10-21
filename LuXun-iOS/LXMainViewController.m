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

@interface LXMainViewController () <UITextViewDelegate> {
  LXCoach *coach;
  LXDict *dictionary;
  NSDate *startingTime;
  NSDate *pinyinTime;
  NSDate *characterTime;
  NSDictionary *coachCharacters;
}


@property (weak, nonatomic) IBOutlet UILabel *helperLabel;
@property (weak, nonatomic) IBOutlet LXPinyinLabel *pinyinLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;


@end

@implementation LXMainViewController

#pragma mark - This Controller only

- (void)nextTrial {
  coachCharacters = [coach nextMove];
  self.helperLabel.text = coachCharacters[@"title"];
  self.pinyinLabel.text = coachCharacters[@"pinyin"];
  startingTime = [NSDate date];
  pinyinTime = characterTime = nil;
}

#pragma mark - ViewController Delegate

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.inputTextView becomeFirstResponder];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
	// Do any additional setup after loading the view, typically from a nib.
  if (!coach) {
    coach = [[LXCoach alloc] init];
  }
  
  if (!dictionary) {
    dictionary = [[LXDict alloc] init];
  }
  
  [self nextTrial];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(LXFlipsideViewController *)controller
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"showAlternate"]) {
    [[segue destinationViewController] setDelegate:self];
  }
}

#pragma mark - UITextFieldDelegate

- (void)textViewDidChange:(UITextView *)textView {
  
  if ([self.helperLabel.text isEqualToString:textView.text]) {
    // log total complete time.
    characterTime = [NSDate date];
    [coach track:coachCharacters pinyinTime:[pinyinTime timeIntervalSinceDate:startingTime] hanziTime:[characterTime timeIntervalSinceDate:pinyinTime]];
    
    self.inputTextView.text = @"";
    [self nextTrial];
    
  }
  
  self.pinyinLabel.text2 = textView.text;
  
}
@end
