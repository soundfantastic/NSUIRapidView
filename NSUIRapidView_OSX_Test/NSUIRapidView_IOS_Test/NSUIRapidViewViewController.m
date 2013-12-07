//
//  NSUIRapidViewViewController.m
//  NSUIRapidView_IOS_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewViewController.h"
#import "UIView+DynamicDraw.h"

@interface NSUIRapidViewViewController ()

@end

@implementation NSUIRapidViewViewController

- (void) draw:(UIView*)view context:(CGContextRef)context {
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(200, 200, 100, 100));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView* mainView = self.view;
    UIView* view_1 = [UIView withBlock:^(UIView *sender, CGContextRef context) {
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(100, 100, 100, 100));
        
    } frame:mainView.frame superDraw:NO];
    [mainView addSubview:view_1];
    
    UIView* view_2 = [UIView withMethod:@selector(draw:context:) target:self frame:mainView.frame superDraw:YES];
    view_2.opaque = NO;
    [mainView addSubview:view_2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
