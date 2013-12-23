//
//  NSUIRapidViewAppDelegate.m
//  NSUIRapidView_OSX_Test
//
//  Created by Dragan Petrovic on 07/12/13.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

#import "NSUIRapidViewAppDelegate.h"
#import "NSView+DynamicDraw.h"
#import "NSView+MouseEvents.h"
#import "NSOpenGLView+DynamicDraw.h"
#import "CommonDrawCode.h"
#import "Life.h"


@implementation NSUIRapidViewAppDelegate

- (void) mouseDown:(NSView*)view event:(NSEvent*)event {
    NSLog(@"%@ %@", view, event);
}
- (void) mouseUp:(NSView*)view event:(NSEvent*)event {
     NSLog(@"%@ %@", view, event);
}
- (void) mouseDragged:(NSView*)view event:(NSEvent*)event {
     view.layer.transform = CATransform3DMakeRotation(1, event.deltaX, event.deltaY, event.deltaZ);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _window.backgroundColor = [NSColor blackColor];
    NSView* mainView = _window.contentView;

    void(^test)(int testChoice) = ^(int testChoice){
        if(testChoice == 0) {
            
            //Conway's game of life
            Life* life = [[Life alloc] init];
            NSView* view = [NSView withMethod:@selector(drawLifeInView:withCGContext:)
                                       target:life
                                        frame:mainView.frame
                                    superDraw:NO];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            [mainView addSubview:view];
            
            //add mouse tracking
            [view mouseDownWithBlock:^(NSView* view, NSEvent *event) {
                NSPoint p = [event locationInWindow];
                if([view mouse:p inRect:view.frame]) {
                    int x = (p.x/CGRectGetWidth(view.frame))*ROWS;
                    int y = (p.y/CGRectGetHeight(view.frame))*COLS;
                    [life setLife_X:x Y:y];
                }
            }];
            [view mouseDraggedWithBlock:^(NSView* view, NSEvent *event) {
                NSPoint p = [event locationInWindow];
                if([view mouse:p inRect:view.frame]) {
                    int x = (p.x/CGRectGetWidth(view.frame))*ROWS;
                    int y = (p.y/CGRectGetHeight(view.frame))*COLS;
                    [life setLife_X:x Y:y];
                }
            }];
            
            [NSTimer scheduledTimerWithTimeInterval:1/2 target:self selector:@selector(drawLife:) userInfo:view repeats:YES];
            
        } else if(testChoice == 1) {
            NSView* view_1 = [NSView withBlock:[CommonCode drawingBlock]
                                         frame:mainView.frame
                                     superDraw:YES];
            view_1.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            [mainView addSubview:view_1];
            NSView* view_2 = [NSView withMethod:@selector(drawingMethod:context:)
                                         target:[CommonCode class]
                                          frame:mainView.frame
                                      superDraw:YES];
            view_2.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            view_2.wantsLayer = YES;
            [mainView addSubview:view_2];
            [view_2 mouseDownWithMethod:@selector(mouseDown:event:) target:self];
            [view_2 mouseUpWithMethod:@selector(mouseUp:event:) target:self];
            [view_2 mouseDraggedWithMethod:@selector(mouseDragged:event:) target:self];
        } else {
            NSOpenGLView* glView = [NSOpenGLView withBlock:^(NSOpenGLView *nsuiView) {
            glClear( GL_COLOR_BUFFER_BIT );
            glColor3f(1.0, 1.0, 1.0);
                
                glBegin(GL_TRIANGLES);
                
                // Front
                glColor3f(1.0f, 0.0f, 0.0f);     // Red
                glVertex3f( 0.0f, 1.0f, 0.0f);
                glColor3f(0.0f, 1.0f, 0.0f);     // Green
                glVertex3f(-1.0f, -1.0f, 1.0f);
                glColor3f(0.0f, 0.0f, 1.0f);     // Blue
                glVertex3f(1.0f, -1.0f, 1.0f);
                
                // Right
                glColor3f(1.0f, 0.0f, 0.0f);     // Red
                glVertex3f(0.0f, 1.0f, 0.0f);
                glColor3f(0.0f, 0.0f, 1.0f);     // Blue
                glVertex3f(1.0f, -1.0f, 1.0f);
                glColor3f(0.0f, 1.0f, 0.0f);     // Green
                glVertex3f(1.0f, -1.0f, -1.0f);
                
                // Back
                glColor3f(1.0f, 0.0f, 0.0f);     // Red
                glVertex3f(0.0f, 1.0f, 0.0f);
                glColor3f(0.0f, 1.0f, 0.0f);     // Green
                glVertex3f(1.0f, -1.0f, -1.0f);
                glColor3f(0.0f, 0.0f, 1.0f);     // Blue
                glVertex3f(-1.0f, -1.0f, -1.0f);
                
                // Left
                glColor3f(1.0f,0.0f,0.0f);       // Red
                glVertex3f( 0.0f, 1.0f, 0.0f);
                glColor3f(0.0f,0.0f,1.0f);       // Blue
                glVertex3f(-1.0f,-1.0f,-1.0f);
                glColor3f(0.0f,1.0f,0.0f);       // Green
                glVertex3f(-1.0f,-1.0f, 1.0f);
                
                glEnd();
                
            } frame:mainView.frame superDraw:NO];
            
            [glView NSUIViewGLSet:^{
                glViewport( 0, 0, NSWidth(glView.frame), NSHeight(glView.frame) );
                glOrtho(-2, 2, -2, 2, -2, 2);
            }];
            [mainView addSubview:glView];
            
            [glView mouseDraggedWithBlock:^(NSOpenGLView* view, NSEvent *event) {
                glRotatef(1, event.deltaX, event.deltaY, event.deltaZ);
                [view setNeedsDisplay:YES];
            }];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0/25.0 target:self selector:@selector(glRotate:) userInfo:glView repeats:YES];
        }
    };
    
    //NSView 0 = Conway's game of life
    //NSOpenGLView 1 = OpenGL
    test(2);
}

- (void) glRotate:(NSTimer*)timer {
    GLfloat f = 1.0/(GLfloat)RAND_MAX;
    GLfloat(^Random)() = ^GLfloat() {
        return rand() * f;
    };
    glRotatef(1, Random(), Random(), 0);
    [timer.userInfo setNeedsDisplay:YES];
}

- (void) drawLife:(NSTimer*)timer {
    NSView* view = [timer userInfo];
    [view setNeedsDisplay:YES];
}

@end
