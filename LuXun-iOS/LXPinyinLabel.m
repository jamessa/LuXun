//
//  LXPinyinLabel.m
//  LuXun-iOS
//
//  Created by jamie on 10/18/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXPinyinLabel.h"
#import "NSString+LuXun.h"

@implementation LXPinyinLabel {
  NSDate *startTime;
  NSMutableArray *lapTimes;
  NSAttributeDescription *style;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code [self.attributedText att]
  }
  return self;
}

- (void)setText:(NSString *)text {
  // reset
  self.characterTimes = [@{}mutableCopy];
  self.text2 = nil;
  startTime = [NSDate date];
  lapTimes = [NSMutableArray arrayWithCapacity:[text length]+1];
  for (int i=0; i<=[text length]; i++) {
    [lapTimes addObject:@(0)];
  }
  
  NSArray *pinyinReadings = [text componentsSeparatedByString:@" "];
  for (NSString *pinyinReading in pinyinReadings) {
    self.characterTimes[pinyinReading] = @1.0f;
  }
  
  self.attributedText = [[NSAttributedString alloc]
                         initWithString:text
                         attributes:
  @{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.9f alpha:1.0f]}];
}

- (void)setText2:(NSString *)text {
  NSRange matchedRange = [self.text rangeOfLongestMatchingSinceBeginning:text];
  if (matchedRange.length) {
    lapTimes[matchedRange.length]= @([startTime timeIntervalSinceNow]);
  }
  
  NSMutableAttributedString *concretePart = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
  
  [concretePart setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.1f alpha:1.0f]} range:matchedRange];
  self.attributedText = concretePart;
  
  // pinyin part finished
  if (matchedRange.length == [self.text length]) {
    for (NSString *pinyin in [self.characterTimes allKeys]) {
      NSRange pinyinRange = [self.text rangeOfString:pinyin];
      NSTimeInterval beginTime = [lapTimes[pinyinRange.location+1] doubleValue];
      NSTimeInterval endTime = [lapTimes[pinyinRange.location+pinyinRange.length] doubleValue];
      self.characterTimes[pinyin] = @(fabs(endTime-beginTime));
      if (_matchedBlock) {
        _matchedBlock(pinyin,fabs(endTime-beginTime));
      }
    }
    
  }
  /* track time here 
   // Pinyin finished, log pinyin reading time.
   if (matchedRange.length == self.pinyinLabel.text.length) {
   pinyinTime = [NSDate date];
   }
   */
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
