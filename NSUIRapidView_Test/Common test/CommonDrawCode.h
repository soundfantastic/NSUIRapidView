//
//  XXViewDraw.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Draw_block)(id view, CGContextRef context);

@interface CommonCode : NSObject

+ (void) drawingMethod:(id)view context:(CGContextRef)context;
+ (Draw_block) drawingBlock;

@end
