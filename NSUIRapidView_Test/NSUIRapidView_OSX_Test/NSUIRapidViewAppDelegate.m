//
//  NSUIRapidViewAppDelegate.m
//  NSUIRapidView_OSX_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewAppDelegate.h"
#import "NSView+DynamicDraw.h"
#import "CommonDrawCode.h"

@implementation NSUIRapidViewAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _window.backgroundColor = [NSColor blackColor];
    NSView* mainView = _window.contentView;
    
    NSView* view_1 = [NSView withBlock:[CommonCode drawingBlock]
                                 frame:mainView.frame
                             superDraw:YES];
    view_1.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [mainView addSubview:view_1];
    
    NSView* view_2 = [NSView withMethod:@selector(drawingMethod:context:)
                                 target:[CommonCode class]
                                  frame:mainView.frame
                              superDraw:YES];
    view_2.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [mainView addSubview:view_2];
}

@end
