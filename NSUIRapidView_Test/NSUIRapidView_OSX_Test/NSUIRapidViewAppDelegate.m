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
#import "Life.h"


@interface NSUIRapidViewAppDelegate ()
@end

@implementation NSUIRapidViewAppDelegate

- (void) mouseDown:(NSView*)view event:(NSEvent*)event {
    NSPoint p = [event locationInWindow];
    if(NSPointInRect(p, view.frame)) {
        
    }
}

- (void) mouseUp:(NSView*)view event:(NSEvent*)event { }

- (void) mouseDragged:(NSOpenGLView*)view event:(NSEvent*)event {
    NSPoint p = [event locationInWindow];
//    if(NSPointInRect(p, view.frame))
    {
        
    }
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _window.backgroundColor = [NSColor blackColor];
    NSView* mainView = _window.contentView;

    //Conway's game of life
    Life* life = [[Life alloc] init];
    NSView* view = [NSView withMethod:@selector(drawLifeInView:withCGContext:)
                               target:life
                                frame:mainView.frame
                            superDraw:NO];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [mainView addSubview:view];
    
    //add mouse tracking
    [view mouseDownWithBlock:^(NSView* view, NSEvent *event) {
        NSPoint p = [event locationInWindow];
        if([view mouse:p inRect:view.frame]) {
            int x = (p.x/CGRectGetWidth(view.frame))*ROWS;
            int y = (p.y/CGRectGetHeight(view.frame))*COLS;
            [life setLife_X:x Y:y];
        }
    }];
    [view mouseDraggedWithBlock:^(NSView* view, NSEvent *event) {
        NSPoint p = [event locationInWindow];
        if([view mouse:p inRect:view.frame]) {
            int x = (p.x/CGRectGetWidth(view.frame))*ROWS;
            int y = (p.y/CGRectGetHeight(view.frame))*COLS;
            [life setLife_X:x Y:y];
        }
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1/2 target:self selector:@selector(nsAnimate:) userInfo:view repeats:YES];
    
}

- (void) nsAnimate:(NSTimer*)timer {
    [timer.userInfo setNeedsDisplay:YES];
}

@end
