//
//  NSUIView.h
//  NSUIView
//
//  Created by Dragan Petrovic on 21/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
    #import <NSUIView/UIView+DynamicDraw.h>
    #import <NSUIView/UIView+TouchesEvents.h>
#else
    #import <NSUIView/NSView+DynamicDraw.h>
    #import <NSUIView/NSView+MouseEvents.h>
#endif
