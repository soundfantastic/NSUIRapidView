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

@interface NSUIRapidViewViewController () {

}


@end

@implementation NSUIRapidViewViewController
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView* mainView = self.view;
    mainView.backgroundColor = [UIColor blackColor];
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
    void(^test)(int m) = ^(int m) {
        if(m == 0) {
            [view_2 touchesBeganWithMethod:@selector(touchesBegan:withEvent:) target:self];
            [view_2 touchesMovedWithMethod:@selector(touchesMoved:withEvent:) target:self];
            [view_2 touchesEndedWithMethod:@selector(touchesEnded:withEvent:) target:self];
            [view_2 touchesCancelledWithMethod:@selector(touchesCancelled:withEvent:) target:self];
        } else {
            [view_2 touchesBeganWithBlock:^(NSSet *touches, UIEvent *event) {
            }];
            [view_2 touchesMovedWithBlock:^(NSSet *touches, UIEvent *event) {
            }];
            [view_2 touchesEndedWithBlock:^(NSSet *touches, UIEvent *event) {
            }];
            [view_2 touchesCancelledWithBlock:^(NSSet *touches, UIEvent *event) {
            }];
        }
    };
    test(1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
