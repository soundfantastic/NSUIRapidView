//
//  XXViewDraw.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "CommonDrawCode.h"

@implementation CommonCode

NS_INLINE void forme(id sender, CGContextRef context, NSColor* color, CGFloat d) {
    CGRect frame = CGRectZero;
#if TARGET_OS_IPHONE
    frame = ((UIView*)sender).frame;
#else
    frame = ((NSView*)sender).frame;
#endif
    CGFloat radius = d * CGRectGetWidth(frame) * 0.5;
    CGFloat t = 15;
    CGFloat theta = 2 * M_PI * (2.0 / t);
    CGContextTranslateCTM (context, CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    CGContextSetRGBStrokeColor(context, color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, 0, radius);
    for(int k = 1; k < (int)t; ++k) {
        CGContextAddLineToPoint (context, radius * sin(k * theta), radius * cos(k * theta));
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

void text(id sender, CGContextRef context, NSString* string, CGPoint p, NSColor* color) {
    CGContextSaveGState(context);
    NSDictionary* dict = @{NSForegroundColorAttributeName: color};
    [string drawAtPoint:p withAttributes:dict];
    CGContextRestoreGState(context);
}

+ (void) drawingMethod:(id)sender context:(CGContextRef)context {
    CGContextSaveGState(context);
    forme(sender, context, [NSColor yellowColor], 0.5);
    CGContextRestoreGState(context);
    text(sender, context, @"Ne", CGPointMake(430, 50), [NSColor orangeColor]);
}

+ (void(^)(id sender, CGContextRef context))drawingBlock {
    return ^(id sender, CGContextRef context) {
        CGContextSaveGState(context);
        forme(sender, context, [NSColor redColor], 0.6);
        CGContextRestoreGState(context);
        text(sender, context, @"Da", CGPointMake(10, 300), [NSColor grayColor]);
    };
}

@end
