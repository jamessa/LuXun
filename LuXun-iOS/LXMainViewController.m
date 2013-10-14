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
  
}


@property (weak, nonatomic) IBOutlet UILabel *helperLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinyinLabel;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;


@end

@implementation LXMainViewController

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
  
  NSDictionary *coachCharacters = [coach nextMove];
  self.helperLabel.text = coachCharacters[@"title"];
  self.pinyinLabel.attributedText = [[NSAttributedString alloc]
                                     initWithString:coachCharacters[@"pinyin"]
                                     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.95f alpha:1.0f]}];
  
  
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
    
    self.inputTextView.text = @"";
    NSDictionary *coachCharacters = [coach nextMove];
    self.helperLabel.text = coachCharacters[@"title"];
    self.pinyinLabel.attributedText = [[NSAttributedString alloc]
                                       initWithString:coachCharacters[@"pinyin"]
                                       attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.95f alpha:1.0f]}];
    
    
  }
  
  NSRange matchedRange = [self.pinyinLabel.text rangeOfLongestMatchingSinceBeginning:textView.text];
  
  NSMutableAttributedString *mutableAttributedString = [self.pinyinLabel.attributedText mutableCopy];
  
  [mutableAttributedString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.1f alpha:1.0f]}
                                   range:matchedRange];
  self.pinyinLabel.attributedText = mutableAttributedString;
  
  if (matchedRange.length == self.pinyinLabel.text.length) {
    NSLog(@"Pinyin reading finished");
  }
  
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  
  NSString *normalizePinyinString = [self.pinyinLabel.text stringByFoldingWithOptions:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch locale:nil];
  
  // should be too long
  if (range.location+range.length >= normalizePinyinString.length) return NO;
  NSString *shouldBeCharacter = [normalizePinyinString substringWithRange:(NSRange){range.location, text.length}];
  
  // if it's a white space, compare to next character
  if ([shouldBeCharacter isEqualToString:@" "]) {
    if (range.location+range.length+1 >= normalizePinyinString.length) return NO;
    shouldBeCharacter = [normalizePinyinString substringWithRange:(NSRange){range.location+1, text.length}];
  }
  
  return YES;
  
}
@end
