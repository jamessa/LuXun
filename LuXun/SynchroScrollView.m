//
//  SynchroScrollView.m
//  LuXun
//
//  Created by jamie on 9/21/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import "SynchroScrollView.h"

@implementation SynchroScrollView {
  NSScrollView *synchronizedScrollView;
}

- (void) setSynchronizeScrollView:(NSScrollView *)scrollview {
  NSView *synchronziedContentView;
  
  [self stopSynchronizing];
  
  synchronizedScrollView = scrollview;
  
  synchronziedContentView = [synchronizedScrollView contentView];
  
  // Make sure the watched view is sending bounds changed
  // notifications (which is probably does anyway, but calling
  // this again won't hurt).
  [synchronziedContentView setPostsBoundsChangedNotifications:YES];
  
  // a register for those notifications on the synchronized content view.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(synchronizedViewContentBoundsDidChange:)
                                               name:NSViewBoundsDidChangeNotification
                                             object:synchronziedContentView];
}

- (void)synchronizedViewContentBoundsDidChange:(NSNotification *)notification {
  NSClipView *changedContentView = [notification object];
  NSPoint changedBoundsOrigin = [changedContentView documentVisibleRect].origin;
  
  NSPoint curOffset = [[self contentView] bounds].origin;
  NSPoint newOffset = curOffset;
  
  // scrolling is synchronized in the vertical plane
  // so only modify the y component of the offset
  newOffset.y = changedBoundsOrigin.y;
  
  // if our synced position is different from our current position,
  // reposition our content view
  NSLog(@"%f, %f", curOffset.y, changedBoundsOrigin.y);
  if (!NSEqualPoints(curOffset, changedBoundsOrigin)) {
    // note that a scroll view watching this one will get notified here
    [[self contentView] scrollToPoint:newOffset];
    // we have to tell the NSScrollView to update its scrollers
    [self reflectScrolledClipView:[self contentView]];
  }
  
}

- (void)stopSynchronizing {
  if (synchronizedScrollView==nil)
    return;
  
  NSView *synchronizedContentView = [synchronizedScrollView contentView];
  
  // remove any existing notification registration
  [[NSNotificationCenter defaultCenter]removeObserver:self
                                                 name:NSViewBoundsDidChangeNotification
                                               object:synchronizedContentView];
  synchronizedScrollView = nil;
}
@end
