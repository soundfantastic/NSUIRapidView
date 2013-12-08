//
//  NSUIRapidViewAppDelegate.m
//  NSUIRapidView_OSX_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewAppDelegate.h"
#import "NSView+DynamicDraw.h"
#import "NSView+MouseEvents.h"
#import "CommonDrawCode.h"

@implementation NSUIRapidViewAppDelegate

- (void) mouseDown:(NSView*)view event:(NSEvent*)event {
    NSLog(@"%@ %@", view, event);
}
- (void) mouseUp:(NSView*)view event:(NSEvent*)event {
     NSLog(@"%@ %@", view, event);
}
- (void) mouseDragged:(NSView*)view event:(NSEvent*)event {
     view.layer.transform = CATransform3DMakeRotation(1, event.deltaX, event.deltaY, event.deltaZ);
}

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
    view_2.wantsLayer = YES;
    [mainView addSubview:view_2];
    
    void(^test)(int m) = ^(int m) {
        if(m == 0) {
            [view_2 mouseDownWithMethod:@selector(mouseDown:event:) target:self];
            [view_2 mouseUpWithMethod:@selector(mouseUp:event:) target:self];
            [view_2 mouseDraggedWithMethod:@selector(mouseDragged:event:) target:self];
        } else {
            [view_2 mouseDownWithBlock:^(NSView* view, NSEvent *event) {
                NSLog(@"%@ %@", view, event);
            }];
            [view_2 mouseUpWithBlock:^(NSView* view, NSEvent *event) {
                NSLog(@"%@ %@", view, event);
            }];
            [view_2 mouseDraggedWithBlock:^(NSView* view, NSEvent *event) {
                view.layer.transform = CATransform3DMakeRotation(1, event.deltaX, event.deltaY, event.deltaZ);
            }];
        }
    };
    test(1);
}

@end
