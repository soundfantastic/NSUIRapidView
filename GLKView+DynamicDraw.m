//
//  GLKView+DynamicDraw.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 26/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "GLKView+DynamicDraw.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation GLKView(dynamicDraw)
static int32_t glViewIndex = 0;

#pragma mark - Private
NS_INLINE void super_drawRect(Class view, CGRect dirtyRect) {
    struct objc_super superView;
    superView.receiver = (id)view;
    superView.super_class = [GLKView class];
    objc_msgSendSuper(&superView, @selector(drawRect:), dirtyRect);
}

NS_INLINE Class view_newClass() {
    NSString *ident = [NSString stringWithFormat:@"GLVIEW_%d", ++glViewIndex];
    return objc_allocateClassPair([GLKView class], [ident UTF8String], 0);
}

+ (EAGLContext*) eaglContext {
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!aContext) {
        NSLog(@"Failed to create ES context");
    }
    return aContext;
}

#pragma mark - Public
+ withBlock:(void(^)(GLKView* sender, EAGLContext* eaglContext))drawingBlock
      frame:(CGRect)frame
  superDraw:(BOOL)superDraw {
    
    Class Subview = view_newClass();
    SEL drawRect = @selector(drawRect:);
    class_addMethod(Subview, drawRect, imp_implementationWithBlock(^(id nsuiView, CGRect dirtyRect) {
        if(superDraw) {
            super_drawRect(Subview, dirtyRect);
        }
        if(drawingBlock) {
            EAGLContext* context = ((GLKView*)nsuiView).context;
            [EAGLContext setCurrentContext:context];
            ((GLKView*)nsuiView).drawableDepthFormat = GLKViewDrawableDepthFormat24;
            drawingBlock(nsuiView, context);
        }
    }), method_getTypeEncoding(class_getInstanceMethod(class_getSuperclass(Subview), drawRect)));
    objc_registerClassPair(Subview);
    return [[Subview alloc] initWithFrame:frame context:[GLKView eaglContext]];
}

- (void) NSUIViewGLSet:(void(^)(void))block {
    if(block) {
        [EAGLContext setCurrentContext:self.context];
        glEnable(GL_DEPTH_TEST);
        block();
    }
}

- (void) dispose {
    if([self class]) {
        objc_disposeClassPair([self class]);
    }
}

@end
