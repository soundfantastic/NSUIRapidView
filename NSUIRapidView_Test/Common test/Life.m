//
//  Life.m
//  NSUIRapidView
//
//  Created by Dragan Petrovic on 10/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "Life.h"

typedef BOOL    Line[ROWS];
typedef Line    Matrix[COLS];

@interface Life() {
    Matrix _life;
    Matrix _newLife;
}
@end

@implementation Life

- (id) init {
    
    if(self=[super init]) {
        srand ((unsigned)time(NULL));
        for(int row = 0; row < ROWS; row++) {
            for(int col = 0; col < COLS; col++) {
                _life[row][col] = (int)rand()%2;
            }
        }
    }
    return self;
}

- (void) setLife_X:(int)x Y:(int)y {
    _life[x][y] = !_life[x][y];
}

- (void) next {
    
	for(int row = 1; row < ROWS; ++row) {
		for(int col = 1; col < COLS; ++col) {
			int n = [self col:col row:row];
			if (_life[row][col]) {
				if (n == 2 || n == 3)
					_newLife[row][col] = YES;
				else
					_newLife[row][col] = NO;
			} else {
				if (n == 3)
					_newLife[row][col] = YES;
				else
					_newLife[row][col] = NO;
			}
		}
	}
	
	for(int row = 0; row < ROWS; ++row) {
		for(int col = 0; col < COLS; ++col) {
			_life[row][col] = _newLife[row][col];
        }
    }
}

- (int) col:(int)col row:(int)row {
    int	n = 0;
    
	if (_life[row-1][col-1])
		n++;
	if (_life[row-1][col])
		n++;
	if (_life[row-1][col+1])
		n++;
	
	if (_life[row][col-1])
		n++;
	if (_life[row][col+1])
		n++;
	
	if (_life[row+1][col-1])
		n++;
	if (_life[row+1][col])
		n++;
	if (_life[row+1][col+1])
		n++;
	
	return n;
}

- (void) drawLifeInView:(id)view withCGContext:(CGContextRef)context {
    
#if TARGET_OS_IPHONE
    CGRect eRect = ((UIView*)view).frame;
#else
    CGRect eRect = ((NSView*)view).frame;
#endif
    CGContextSetRGBFillColor(context, .0, .0, .0, 1.0);
    CGContextFillRect(context, eRect);
    
    CGFloat width = CGRectGetWidth(eRect)/(CGFloat)ROWS;
    CGFloat height = CGRectGetHeight(eRect)/(CGFloat)COLS;
    for(int sy = 0; sy < ROWS; sy++) {
        for(int sx = 0; sx < COLS; ++sx) {
            CGFloat xPos = sx*width;
            CGFloat yPos = sy*height;
            CGRect lifeRect = CGRectMake(xPos, yPos, width, height);
            CGColorRef color = NULL;
            BOOL l = _life[sx][sy];
            if(l) {
#if TARGET_OS_IPHONE
                color = [UIColor redColor].CGColor;
#else
                color = [NSColor redColor].CGColor;
#endif
                CGContextSetFillColorWithColor(context, color);
                CGContextFillRect(context, lifeRect);
            } 
        }
    }
   
    [self next];
}

@end
