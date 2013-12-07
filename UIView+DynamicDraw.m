//
//  UIView+DynamicDraw.m
//  RapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "UIView+DynamicDraw.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIView (injectDraw)

static int32_t viewIndex = 0;

#pragma mark - Private
NS_INLINE void super_DrawRect(Class view, CGRect dirtyRect) {
    struct objc_super superView;
    superView.receiver = (id)view;
    superView.super_class = [UIView class];
    objc_msgSendSuper(&superView, @selector(drawRect:), dirtyRect);
}

NS_INLINE Class view_new_Class() {
    NSString *ident = [NSString stringWithFormat:@"VIEW_%d", ++viewIndex];
    return objc_allocateClassPair([UIView class], [ident UTF8String], 0);
}

#pragma mark - Public
+ withBlock:(void(^)(UIView* sender, CGContextRef context))drawingBlock frame:(CGRect)frame superDraw:(BOOL)superDraw {
    Class Subview = view_new_Class();
    class_addMethod(Subview, @selector(drawRect:), imp_implementationWithBlock(^(id sender, CGRect dirtyRect) {
        if(superDraw) {
            super_DrawRect(Subview, dirtyRect);
        }
        if(drawingBlock) {
            CGContextRef graphicContext = UIGraphicsGetCurrentContext();
            drawingBlock(sender, graphicContext);
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), @selector(drawRect:))));
    
    return [[Subview alloc] initWithFrame:frame];
}

+ withMethod:(SEL)selector target:(id)target frame:(CGRect)frame superDraw:(BOOL)superDraw {
    Class Subview = view_new_Class();
    class_addMethod(Subview, @selector(drawRect:), imp_implementationWithBlock(^(id sender, CGRect dirtyRect) {
        if(superDraw) {
            super_DrawRect(Subview, dirtyRect);
        }
        if(class_respondsToSelector(object_getClass(target), selector)) {
            CGContextRef graphicContext = UIGraphicsGetCurrentContext();
            objc_msgSend(target, selector, sender, graphicContext);
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), @selector(drawRect:))));
    
    return [[Subview alloc] initWithFrame:frame];
}

@end
