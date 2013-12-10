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
    
    void(^test)(int testChoice) = ^(int testChoice){
        if(testChoice == 0) {
            
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
            
            [NSTimer scheduledTimerWithTimeInterval:1/2 target:self selector:@selector(drawLife:) userInfo:view repeats:YES];
            
        } else {
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
            [view_2 mouseDownWithMethod:@selector(mouseDown:event:) target:self];
            [view_2 mouseUpWithMethod:@selector(mouseUp:event:) target:self];
            [view_2 mouseDraggedWithMethod:@selector(mouseDragged:event:) target:self];
        }
    };
    
    //Test 0 = Conways game of life
    //Test 1 = Star & text
    test(0);
}

- (void) drawLife:(NSTimer*)timer {
    NSView* view = [timer userInfo];
    [view setNeedsDisplay:YES];
}

@end
