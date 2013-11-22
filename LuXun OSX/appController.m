//
//  appController.m
//  LuXun
//
//  Created by jamie on 11/22/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "appController.h"
#import "LXCoach.h"

@interface appController () {
  LXCoach *coach;
}
@end

@implementation appController  {
}

-(id)init {
  self = [super init];
  if(!self)
    return nil;
  
  coach = [[LXCoach alloc] init];
  
  return self;
}

- (void)awakeFromNib {
  [self newTrial];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:_inputTextField];
}

- (void)newTrial {
  NSDictionary *coachCharacter = [coach nextMove];
  ((NSTextFieldCell*)_pinyinTextField.cell).title = coachCharacter[@"pinyin"];
  ((NSTextFieldCell*)_hanziTextField.cell).title = coachCharacter[@"title"];
}

#pragma mark - Notification
- (void)controlTextDidChange:(NSNotification *)notification {
  NSLog(@"%@", ((NSTextFieldCell*)_inputTextField.cell).title);
  
}
@end
