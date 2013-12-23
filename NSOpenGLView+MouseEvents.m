//
//  NSOpenGLView+MouseEvents.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 23/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSOpenGLView+MouseEvents.h"
#import <objc/objc-runtime.h>

@implementation NSOpenGLView (mouseEvents)

#pragma mark - mouseDown:
- (void) mouseDownWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL mouseDown = @selector(mouseDown:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), mouseDown);
    class_addMethod(Subview, mouseDown, imp_implementationWithBlock(^(id nsuiView, NSEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            [[nsuiView openGLContext] makeCurrentContext];
            objc_msgSend(target, selector, nsuiView, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) mouseDownWithBlock:(void(^)(id sender, NSEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL mouseDown = @selector(mouseDown:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), mouseDown);
    class_addMethod(Subview, mouseDown, imp_implementationWithBlock(^(id nsuiView, NSEvent* event) {
        if(eventBlock) {
            [[nsuiView openGLContext] makeCurrentContext];
            eventBlock(nsuiView, event);
        }
    }), method_getTypeEncoding(method));
}

#pragma mark - mouseDragged
- (void) mouseDraggedWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL mouseDragged = @selector(mouseDragged:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), mouseDragged);
    class_addMethod(Subview, mouseDragged, imp_implementationWithBlock(^(id nsuiView, NSEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            [[nsuiView openGLContext] makeCurrentContext];
            objc_msgSend(target, selector, nsuiView, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) mouseDraggedWithBlock:(void(^)(id sender, NSEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL mouseDragged = @selector(mouseDragged:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), mouseDragged);
    class_addMethod(Subview, mouseDragged, imp_implementationWithBlock(^(id nsuiView, NSEvent* event) {
        if(eventBlock) {
            [[nsuiView openGLContext] makeCurrentContext];
            eventBlock(nsuiView, event);
        }
    }), method_getTypeEncoding(method));
}

#pragma mark - mouseUp
- (void) mouseUpWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL mouseUp = @selector(mouseUp:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), mouseUp);
    class_addMethod(Subview, mouseUp, imp_implementationWithBlock(^(id nsuiView, NSEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            [[nsuiView openGLContext] makeCurrentContext];
            objc_msgSend(target, selector, nsuiView, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) mouseUpWithBlock:(void(^)(id sender, NSEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL mouseUp = @selector(mouseUp:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), mouseUp);
    class_addMethod(Subview, mouseUp, imp_implementationWithBlock(^(id nsuiView, NSEvent* event) {
        if(eventBlock) {
            [[nsuiView openGLContext] makeCurrentContext];
            eventBlock(nsuiView, event);
        }
    }), method_getTypeEncoding(method));
}

@end
