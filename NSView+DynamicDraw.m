//
//  NSView+DynamicDraw.m
//  RapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSView+DynamicDraw.h"
#import <objc/objc-runtime.h>

@implementation NSView (injectDraw)

static int32_t viewIndex = 0;

#pragma mark - Private
NS_INLINE void super_drawRect(Class view, NSRect dirtyRect) {
    struct objc_super superView;
    superView.receiver = (id)view;
    superView.super_class = [NSView class];
    objc_msgSendSuper(&superView, @selector(drawRect:), dirtyRect);
}

NS_INLINE Class view_newClass() {
    NSString *ident = [NSString stringWithFormat:@"VIEW_%d", ++viewIndex];
    return objc_allocateClassPair([NSView class], [ident UTF8String], 0);
}

#pragma mark - Public
+ withBlock:(void(^)(NSView* sender, CGContextRef context))drawingBlock frame:(NSRect)frame superDraw:(BOOL)superDraw {
    Class Subview = view_newClass();
    class_addMethod(Subview, @selector(drawRect:), imp_implementationWithBlock(^(id sender, NSRect dirtyRect) {
        if(superDraw) {
            super_drawRect(Subview, dirtyRect);
        }
        if(drawingBlock) {
            CGContextRef graphicContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
            drawingBlock(sender, graphicContext);
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), @selector(drawRect:))));
    
    return [[Subview alloc] initWithFrame:frame];
}

+ withMethod:(SEL)selector target:(id)target frame:(NSRect)frame superDraw:(BOOL)superDraw {
    Class Subview = view_newClass();
    class_addMethod(Subview, @selector(drawRect:), imp_implementationWithBlock(^(id sender, NSRect dirtyRect) {
        if(superDraw) {
            super_drawRect(Subview, dirtyRect);
        }
        if(class_respondsToSelector(object_getClass(target), selector)) {
            CGContextRef graphicContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
            objc_msgSend(target, selector, sender, graphicContext);
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), @selector(drawRect:))));
    
    return [[Subview alloc] initWithFrame:frame];
}

@end
