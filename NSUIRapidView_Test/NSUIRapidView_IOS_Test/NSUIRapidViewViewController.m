//
//  NSUIRapidViewViewController.m
//  NSUIRapidView_IOS_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewViewController.h"
#import "UIView+DynamicDraw.h"
#import "UIView+TouchesEvents.h"
#import "CommonDrawCode.h"
#import "Life.h"

@interface NSUIRapidViewViewController () {}
@end

@implementation NSUIRapidViewViewController
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", touches);
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", touches);
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", touches);
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", touches);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView* mainView = self.view;
    mainView.backgroundColor = [UIColor blackColor];
    
    void(^test)(int testChoice) = ^(int testChoice){
        if(testChoice == 0) {
            
            //Conway's game of life
            Life* life = [[Life alloc] init];
            UIView* view = [UIView withMethod:@selector(drawLifeInView:withCGContext:)
                                       target:life
                                        frame:mainView.frame
                                    superDraw:NO];
            [mainView addSubview:view];
            
            //add touches tracking
            [view touchesBeganWithBlock:^(NSSet* touches, UIEvent *event) {
                UITouch *touch = [touches anyObject];
                CGPoint p = [touch locationInView:touch.view];
                int x = (p.x/CGRectGetWidth(touch.view.frame))*ROWS;
                int y = (p.y/CGRectGetHeight(touch.view.frame))*COLS;
                [life setLife_X:x Y:y];
            }];
            [view touchesMovedWithBlock:^(NSSet* touches, UIEvent *event) {
                UITouch *touch = [touches anyObject];
                CGPoint p = [touch locationInView:touch.view];
                int x = (p.x/CGRectGetWidth(touch.view.frame))*ROWS;
                int y = (p.y/CGRectGetHeight(touch.view.frame))*COLS;
                [life setLife_X:x Y:y];
            }];
            
            [NSTimer scheduledTimerWithTimeInterval:1/2 target:self selector:@selector(drawLife:) userInfo:view repeats:YES];
        } else {
            
            UIView* view_1 = [UIView withBlock:[CommonCode drawingBlock]
                                         frame:mainView.frame
                                     superDraw:YES];
            view_1.opaque = NO;
            [mainView addSubview:view_1];
            
            UIView* view_2 = [UIView withMethod:@selector(drawingMethod:context:)
                                         target:[CommonCode class]
                                          frame:mainView.frame
                                      superDraw:YES];
            view_2.opaque = NO;
            [mainView addSubview:view_2];
            [view_2 touchesBeganWithMethod:@selector(touchesBegan:withEvent:) target:self];
            [view_2 touchesMovedWithMethod:@selector(touchesMoved:withEvent:) target:self];
            [view_2 touchesEndedWithMethod:@selector(touchesEnded:withEvent:) target:self];
            [view_2 touchesCancelledWithMethod:@selector(touchesCancelled:withEvent:) target:self];
        }
    };
    
    test(0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawLife:(NSTimer*)timer {
    UIView* view = [timer userInfo];
    [view setNeedsDisplay];
}

@end
