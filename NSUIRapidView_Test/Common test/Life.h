//
//  Life.h
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 10/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ROWS 256
#define COLS 256

@interface Life : NSObject
- (void) drawLifeInView:(id)view withCGContext:(CGContextRef)context;
- (void) setLife_X:(int)x Y:(int)y;
@end
