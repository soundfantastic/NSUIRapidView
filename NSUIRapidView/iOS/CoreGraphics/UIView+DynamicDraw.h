//
//  UIView+DynamicDraw.h
//  RapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (injectDraw)

+ withBlock:(void(^)(UIView* sender, CGContextRef context))drawingBlock
      frame:(CGRect)frame
  superDraw:(BOOL)superDraw;

+ withMethod:(SEL)selector
      target:(id)target
       frame:(CGRect)frame
   superDraw:(BOOL)superDraw;

- (void) dispose;

@end
