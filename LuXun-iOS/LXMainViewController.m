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

@interface LXMainViewController () <UITextViewDelegate> {
  LXCoach *coach;
  LXDict *dictionary;
  NSDate *startingTime;
  NSDate *pinyinTime;
  NSDate *characterTime;
  NSDictionary *coachCharacters;
}


@property (weak, nonatomic) IBOutlet UILabel *helperLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinyinLabel;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;


@end

@implementation LXMainViewController

#pragma mark - This Controller only

- (void)nextTrial {
  coachCharacters = [coach nextMove];
  self.helperLabel.text = coachCharacters[@"title"];
  self.pinyinLabel.attributedText = [[NSAttributedString alloc]
                                     initWithString:coachCharacters[@"pinyin"]
                                     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.95f alpha:1.0f]}];
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

#pragma mark #UITextFieldDelegate



- (void)textViewDidChange:(UITextView *)textView {
  
  if ([self.helperLabel.text isEqualToString:textView.text]) {
    // log total complete time.
    characterTime = [NSDate date];
    [coach track:coachCharacters pinyinTime:[pinyinTime timeIntervalSinceDate:startingTime] hanziTime:[characterTime timeIntervalSinceDate:pinyinTime]];
    
    self.inputTextView.text = @"";
    [self nextTrial];

  }
  
  NSRange matchedRange = [self.pinyinLabel.text rangeOfLongestMatchingSinceBeginning:textView.text];
  
  NSMutableAttributedString *mutableAttributedString = [self.pinyinLabel.attributedText mutableCopy];
  
  [mutableAttributedString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.1f alpha:1.0f]}
                                   range:matchedRange];
  self.pinyinLabel.attributedText = mutableAttributedString;
  
  if (matchedRange.length == self.pinyinLabel.text.length) {
    // Pinyin finished, log pinyin reading time.
    NSLog(@"Pinyin reading finished");
    pinyinTime = [NSDate date];
  }
  
}

@end
