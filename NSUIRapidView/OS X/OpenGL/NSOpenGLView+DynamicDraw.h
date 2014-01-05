//
//  NSOpenGLView+DynamicDraw.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 23/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSOpenGLView (dynamicDraw)

+ withBlock:(void(^)(NSOpenGLView* nsuiView))drawingBlock
      frame:(NSRect)frame
  superDraw:(BOOL)superDraw;

+ withMethod:(SEL)selector
      target:(id)target
       frame:(NSRect)frame
   superDraw:(BOOL)superDraw;

- (void) glSetWithBlock:(void(^)(void))block;
- (void) glSetWithMethod:(SEL)method
                  target:(id)target;
- (GLuint) glVertex:(NSString*)vertex
           fragment:(NSString*)fragment;
- (void) dispose;

@end
