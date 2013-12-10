//
//  XXViewDraw.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "CommonDrawCode.h"

@implementation CommonCode

NS_INLINE void forme(id sender, CGContextRef context, CGFloat* color, CGFloat d) {
    CGRect frame = CGRectZero;
#if TARGET_OS_IPHONE
    frame = ((UIView*)sender).frame;
#else
    frame = ((NSView*)sender).frame;
#endif
    CGFloat radius = d * CGRectGetWidth(frame) * 0.5;
    CGFloat t = 5;
    CGFloat theta = 2 * M_PI * (2.0 / t);
    CGContextTranslateCTM (context, CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    CGContextSetRGBStrokeColor(context, color[0], color[1], color[2], color[3]);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, 0, radius);
    for(int k = 1; k < (int)t; ++k) {
        CGContextAddLineToPoint (context, radius * sin(k * theta), radius * cos(k * theta));
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

void text(id sender, CGContextRef context, NSString* string, CGPoint p, CGFloat* color) {
    CGContextSaveGState(context);
    NSDictionary* dict = nil;
#if TARGET_OS_IPHONE
    dict = @{NSForegroundColorAttributeName: [UIColor colorWithRed:color[0] green:color[1] blue:color[2] alpha:color[3]]};
#else
    dict = @{NSForegroundColorAttributeName: [NSColor colorWithCalibratedRed:color[0] green:color[1] blue:color[2] alpha:color[3]]};
#endif
    [string drawAtPoint:p withAttributes:dict];
    CGContextRestoreGState(context);
}

+ (void) drawingMethod:(id)sender context:(CGContextRef)context {
    CGContextSaveGState(context);
    CGFloat color[] = {1, 0, 0, 1};
    forme(sender, context, color, 0.5);
    CGContextRestoreGState(context);
    CGFloat color2[] = {0.8, 0.2, 0.2, 1};
    text(sender, context, @"Ne", CGPointMake(10, 50), color2);
}

+ (void(^)(id sender, CGContextRef context))drawingBlock {
    return ^(id sender, CGContextRef context) {
        CGContextSaveGState(context);
        CGFloat color[] = {1, 1, 0, 1};
        forme(sender, context, color, 0.6);
        CGContextRestoreGState(context);
        CGFloat color2[] = {0.8, 0.8, 0.8, 1};
        text(sender, context, @"Da", CGPointMake(10, 300), color2);
    };
}

@end
