//
//  NSUIRapidViewViewController.m
//  NSUIRapidView_IOS_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewViewController.h"
#import "UIView+DynamicDraw.h"
#import "CommonDrawCode.h"

@interface NSUIRapidViewViewController ()

@end

@implementation NSUIRapidViewViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
