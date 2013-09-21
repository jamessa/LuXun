//
//  SynchroScrollView.h
//  LuXun
//
//  Created by jamie on 9/21/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SynchroScrollView : NSScrollView

- (void) setSynchronizeScrollView:(NSScrollView *)scrollview;
- (void) stopSynchronizing;
- (void) synchronizedViewContentBoundsDidChange:(NSNotification *)notification;

@end
