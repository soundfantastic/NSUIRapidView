//
//  UIView+TouchesEvents.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 08/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "UIView+TouchesEvents.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIView (touchesEvents)

#pragma mark - touchBegan:
- (void) touchesBeganWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL touchesBegan = @selector(touchesBegan:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesBegan);
    class_addMethod(Subview, touchesBegan, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            objc_msgSend(target, selector, touches, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) touchesBeganWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL touchesBegan = @selector(touchesBegan:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesBegan);
    class_addMethod(Subview, touchesBegan, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(eventBlock) {
            eventBlock(touches, event);
        }
    }), method_getTypeEncoding(method));
}

#pragma mark - touchesMoved
- (void) touchesMovedWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL touchesMoved = @selector(touchesMoved:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesMoved);
    class_addMethod(Subview, touchesMoved, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            objc_msgSend(target, selector, touches, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) touchesMovedWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL touchesMoved = @selector(touchesMoved:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesMoved);
    class_addMethod(Subview, touchesMoved, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(eventBlock) {
            eventBlock(touches, event);
        }
    }), method_getTypeEncoding(method));
}

#pragma mark - touchesEnded
- (void) touchesEndedWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL touchesEnded = @selector(touchesEnded:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesEnded);
    class_addMethod(Subview, touchesEnded, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            objc_msgSend(target, selector, touches, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) touchesEndedWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL touchesEnded = @selector(touchesEnded:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesEnded);
    class_addMethod(Subview, touchesEnded, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(eventBlock) {
            eventBlock(touches, event);
        }
    }), method_getTypeEncoding(method));
}

#pragma mark - touchesCancelled
- (void) touchesCancelledWithMethod:(SEL)selector target:(id)target {
    Class Subview = object_getClass(self);
    SEL touchesCancelled = @selector(touchesCancelled:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesCancelled);
    class_addMethod(Subview, touchesCancelled, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(class_respondsToSelector(object_getClass(target), selector)) {
            objc_msgSend(target, selector, touches, event);
        }
    }), method_getTypeEncoding(method));
}

- (void) touchesCancelledWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock {
    Class Subview = object_getClass(self);
    SEL touchesCancelled = @selector(touchesCancelled:withEvent:);
    Method method = class_getInstanceMethod(class_getSuperclass(Subview), touchesCancelled);
    class_addMethod(Subview, touchesCancelled, imp_implementationWithBlock(^(id sender, NSSet* touches, UIEvent* event) {
        if(eventBlock) {
            eventBlock(touches, event);
        }
    }), method_getTypeEncoding(method));
}


@end
