//
//  NSView+DynamicDraw.h
//  RapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (injectDraw)

+ withBlock:(void(^)(NSView* nsuiView, CGContextRef context))drawingBlock
      frame:(NSRect)frame
  superDraw:(BOOL)superDraw;

+ withMethod:(SEL)selector
      target:(id)target
       frame:(NSRect)frame
   superDraw:(BOOL)superDraw;

- (void) dispose;

@end
