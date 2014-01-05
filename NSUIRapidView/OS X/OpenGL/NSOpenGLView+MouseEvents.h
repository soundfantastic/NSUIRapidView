//
//  NSOpenGLView+MouseEvents.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 23/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSOpenGLView (mouseEvents)
- (void) mouseDownWithBlock:(void(^)(id sender, NSEvent* event))eventBlock;
- (void) mouseUpWithBlock:(void(^)(id sender, NSEvent* event))eventBlock;
- (void) mouseDraggedWithBlock:(void(^)(id sender, NSEvent* event))eventBlock;
@end
