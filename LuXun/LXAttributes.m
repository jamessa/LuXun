//
//  LXAttributes.m
//  LuXun
//
//  Created by jamie on 9/25/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import "LXAttributes.h"

@implementation LXAttributes

+ (NSDictionary *)attributesForTemplateTextView {
  NSFont *font = [NSFont fontWithName:@"Heiti TC" size:24.f];
  NSNumber *fontSize = @48.f;
  NSColor *fontColor = [NSColor colorWithCalibratedWhite:(255.f-57.f)/255.f alpha:1.f];
  
  NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle]mutableCopy];
  [paragraphStyle setLineHeightMultiple:1.0f];
  [paragraphStyle setLineSpacing:48.f];
  
  
  return @{NSFontAttributeName: font,
           NSFontSizeAttribute:fontSize,
           NSKernAttributeName: @6.f,
           NSParagraphStyleAttributeName:paragraphStyle,
           NSForegroundColorAttributeName:fontColor
           };
}

+ (NSDictionary *)attributesForInputTextView {
  NSFont *font = [NSFont fontWithName:@"Heiti TC" size:24.f];
  NSNumber *fontSize = @48.f;
  NSColor *fontColor = [NSColor colorWithCalibratedWhite:0.f/255.f alpha:1.f];
  
  NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle]mutableCopy];
  [paragraphStyle setLineHeightMultiple:1.0f];
  [paragraphStyle setLineSpacing:48.f];
  
  return @{NSFontAttributeName: font,
           NSFontSizeAttribute:fontSize,
           NSKernAttributeName: @6.f,
           NSParagraphStyleAttributeName:paragraphStyle,
           NSForegroundColorAttributeName:fontColor
           };

}

@end
