//
//  NSView+MouseEvents.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 08/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (mouseEvents)
- (void) mouseDownWithMethod:(SEL)selector target:(id)target;
- (void) mouseDownWithBlock:(void(^)(id sender, NSEvent* event))eventBlock;
- (void) mouseUpWithMethod:(SEL)selector target:(id)target;
- (void) mouseUpWithBlock:(void(^)(id sender, NSEvent* event))eventBlock;
- (void) mouseDraggedWithMethod:(SEL)selector target:(id)target;
- (void) mouseDraggedWithBlock:(void(^)(id sender, NSEvent* event))eventBlock;
@end
