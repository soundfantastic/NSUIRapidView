//
//  NSOpenGLView+DynamicDraw.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 23/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

@interface NSOpenGLView (dynamicDraw)

+ withBlock:(void(^)(NSOpenGLView* nsuiView))drawingBlock
      frame:(NSRect)frame
  superDraw:(BOOL)superDraw;

+ withMethod:(SEL)selector
      target:(id)target
       frame:(NSRect)frame
   superDraw:(BOOL)superDraw;

- (void) NSUIViewGLSet:(void(^)(void))block;
- (void) dispose;

@end
