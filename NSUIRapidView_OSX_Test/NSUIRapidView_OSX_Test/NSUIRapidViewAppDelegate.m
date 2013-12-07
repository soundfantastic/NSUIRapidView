//
//  NSUIRapidViewAppDelegate.m
//  NSUIRapidView_OSX_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewAppDelegate.h"
#import "NSView+DynamicDraw.h"

@implementation NSUIRapidViewAppDelegate

- (void) draw:(NSView*)view context:(CGContextRef)context {
    CGContextSetFillColorWithColor(context, [NSColor yellowColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(200, 200, 100, 100));
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _window.backgroundColor = [NSColor blackColor];
    NSView* mainView = _window.contentView;
    NSView* view_1 = [NSView withBlock:^(NSView *sender, CGContextRef context) {
        CGContextSetFillColorWithColor(context, [NSColor redColor].CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(100, 100, 100, 100));
        
    } frame:mainView.frame superDraw:NO];
    [mainView addSubview:view_1];
    
    NSView* view_2 = [NSView withMethod:@selector(draw:context:) target:self frame:mainView.frame superDraw:YES];
    [mainView addSubview:view_2];
}

@end
