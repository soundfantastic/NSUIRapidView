//
//  NSOpenGLView+DynamicDraw.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 23/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSOpenGLView+DynamicDraw.h"
#import <objc/objc-runtime.h>

@implementation NSOpenGLView (dynamicDraw)

static int32_t glViewIndex = 0;

#pragma mark - Private

+ (NSOpenGLPixelFormat*) glDefaultPixelFormat {
    
    NSOpenGLPixelFormatAttribute attributes [] = {
        NSOpenGLPFAScreenMask, 0,
        NSOpenGLPFANoRecovery,
        NSOpenGLPFADoubleBuffer,
        (NSOpenGLPixelFormatAttribute)nil };
    CGDirectDisplayID display = CGMainDisplayID ();
    attributes[1] = (NSOpenGLPixelFormatAttribute)CGDisplayIDToOpenGLDisplayMask (display);
    return [(NSOpenGLPixelFormat *)[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
}

NS_INLINE void super_drawRect(Class view, NSRect dirtyRect) {
    struct objc_super superView;
    superView.receiver = (id)view;
    superView.super_class = [NSOpenGLView class];
    objc_msgSendSuper(&superView, @selector(drawRect:), dirtyRect);
}

NS_INLINE Class view_newClass() {
    NSString *ident = [NSString stringWithFormat:@"GLVIEW_%d", ++glViewIndex];
    return objc_allocateClassPair([NSOpenGLView class], [ident UTF8String], 0);
}

+ withBlock:(void(^)(NSOpenGLView* nsuiView))drawingBlock
      frame:(NSRect)frame
  superDraw:(BOOL)superDraw {
    
    Class Subview = view_newClass();
    SEL drawRect = @selector(drawRect:);
    class_addMethod(Subview, drawRect, imp_implementationWithBlock(^(id nsuiView, NSRect dirtyRect) {
        if(superDraw) {
            super_drawRect(Subview, dirtyRect);
        }
        if(drawingBlock) {
            [[nsuiView openGLContext] makeCurrentContext];
            drawingBlock(nsuiView);
            [[nsuiView openGLContext] flushBuffer];
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), drawRect)));
    objc_registerClassPair(Subview);
    return [[Subview alloc] initWithFrame:frame pixelFormat:[NSOpenGLView glDefaultPixelFormat]];
}

+ withMethod:(SEL)selector
      target:(id)target
       frame:(NSRect)frame
   superDraw:(BOOL)superDraw {
    
    Class Subview = view_newClass();
    SEL drawRect = @selector(drawRect:);
    class_addMethod(Subview, drawRect, imp_implementationWithBlock(^(id nsuiView, NSRect dirtyRect) {
        if(superDraw) {
            super_drawRect(Subview, dirtyRect);
        }
        if(class_respondsToSelector(object_getClass(target), selector)) {
            [[nsuiView openGLContext] makeCurrentContext];
            objc_msgSend(target, selector, nsuiView);
            [[nsuiView openGLContext] flushBuffer];
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), drawRect)));
    objc_registerClassPair(Subview);
    return [[Subview alloc] initWithFrame:frame pixelFormat:[NSOpenGLView glDefaultPixelFormat]];
}

- (void) NSUIViewGLSet:(void(^)(void))block {
    if(block) {
        [[self openGLContext] makeCurrentContext];
        block();
    }
}

- (void) dispose {
    if([self class]) {
        objc_disposeClassPair([self class]);
    }
}

@end
