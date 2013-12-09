//
//  XXViewDraw.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonCode : NSObject
+ (void) drawingMethod:(id)view context:(CGContextRef)context;
+ (void(^)(id sender, CGContextRef context))drawingBlock;
@end
