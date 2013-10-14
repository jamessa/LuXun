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

@interface LXMainViewController () <UITextViewDelegate> {
  LXCoach *coach;
  LXDict *dictionary;
  
}


@property (weak, nonatomic) IBOutlet UILabel *helperLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinyinLabel;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;


@end

@implementation LXMainViewController

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
    self.helperLabel.text = [coach nextMove];
  FMResultSet *s = [dictionary pinyinReadingForCharacters:self.helperLabel.text];
  [s next];
  self.pinyinLabel.text = s.resultDictionary[@"pinyin"];
  
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
  NSLog(@"%@", textView.text);
  
  if ([self.helperLabel.text isEqualToString:textView.text]) {
    NSLog(@"Bingo");
    self.helperLabel.text = [coach nextMove];
    self.inputTextView.text = @"";
    FMResultSet *s = [dictionary pinyinReadingForCharacters:self.helperLabel.text];
    [s next];
    self.pinyinLabel.text = s.resultDictionary[@"pinyin"];
    
  }
}
@end
