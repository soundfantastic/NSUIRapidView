//
//  XXViewDraw.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "CommonDrawCode.h"

@implementation CommonCode

+ (void) drawingMethod:(id)sender context:(CGContextRef)context {
    CGRect frame = CGRectZero;
#if TARGET_OS_IPHONE
    frame = ((UIView*)sender).frame;
#else
    frame = ((NSView*)sender).frame;
#endif
    CGFloat radius = 0.5 * CGRectGetWidth(frame) * 0.5;
    CGFloat theta = 2 * M_PI * (2.0 / 5.0);
    CGContextTranslateCTM (context, CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 8);
    CGContextMoveToPoint(context, 0, radius);
    for(int k = 1; k < 5; ++k) {
        CGContextAddLineToPoint (context, radius * sin(k * theta), radius * cos(k * theta));
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

+ (Draw_block) drawingBlock {
    return ^(id sender, CGContextRef context) {
        CGRect frame = CGRectZero;
#if TARGET_OS_IPHONE
        frame = ((UIView*)sender).frame;
#else
        frame = ((NSView*)sender).frame;
        
#endif
        CGFloat radius = 0.8 * CGRectGetWidth(frame) * 0.5;
        CGFloat theta = 2 * M_PI * (2.0 / 5.0);
        CGContextTranslateCTM (context, CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
        CGContextSetLineWidth(context, 8);
        CGContextMoveToPoint(context, 0, radius);
        for(int k = 1; k < 5; ++k) {
            CGContextAddLineToPoint (context, radius * sin(k * theta), radius * cos(k * theta));
        }
        CGContextClosePath(context);
        CGContextStrokePath(context);
    };
}

@end
