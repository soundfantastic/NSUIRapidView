//
//  GLKView+DynamicDraw.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 26/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface GLKView(dynamicDraw)

+ withBlock:(void(^)(GLKView* sender, EAGLContext* eaglContext))drawingBlock
      frame:(CGRect)frame
  superDraw:(BOOL)superDraw;
- (void) NSUIViewGLSet:(void(^)(void))block;
- (void) dispose;

@end
