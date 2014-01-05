//
//  UIView+TouchesEvents.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 08/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (touchesEvents)
- (void) touchesBeganWithMethod:(SEL)selector target:(id)target;
- (void) touchesMovedWithMethod:(SEL)selector target:(id)target;
- (void) touchesEndedWithMethod:(SEL)selector target:(id)target;
- (void) touchesCancelledWithMethod:(SEL)selector target:(id)target;
- (void) touchesBeganWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock;
- (void) touchesMovedWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock;
- (void) touchesEndedWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock;
- (void) touchesCancelledWithBlock:(void(^)(NSSet* touches, UIEvent* event))eventBlock;
@end
