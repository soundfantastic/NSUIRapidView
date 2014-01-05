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

@interface NSUIRapidViewAppDelegate () {
}
@property (nonatomic, assign)   GLint       time;
@property (nonatomic, assign)   GLint       resolution;
@property (nonatomic, assign)   GLint       mouse;
@property (nonatomic)           GLfloat     timeValue;
@property (nonatomic)           GLfloat*    resolutionValue;
@property (nonatomic)           GLfloat*    mouseValue;
@end

@implementation NSUIRapidViewAppDelegate

- (void) mouseDown:(NSView*)view event:(NSEvent*)event {
    NSPoint p = [event locationInWindow];
    if(NSPointInRect(p, view.frame)) {
        _mouseValue[0] = p.x/NSWidth(view.frame);
        _mouseValue[1] = p.y/NSHeight(view.frame);
        glUniform2fv(_mouse, 1, _mouseValue);
        [view setNeedsDisplay:YES];
    }
}

- (void) mouseUp:(NSView*)view event:(NSEvent*)event { }

- (void) mouseDragged:(NSOpenGLView*)view event:(NSEvent*)event {
    NSPoint p = [event locationInWindow];
//    if(NSPointInRect(p, view.frame))
    {
        _mouseValue[0] = p.x/NSWidth(view.frame);
        _mouseValue[1] = p.y/NSHeight(view.frame);
        glUniform2fv(_mouse, 1, _mouseValue);
        [view setNeedsDisplay:YES];
    }
}

- (void) GLSet:(NSOpenGLView*)glView {
    glViewport( 0, 0, NSWidth(glView.frame), NSHeight(glView.frame) );
    glOrtho(-1, 1, -1, 1, -1, 1);
    glClearColor(0, 0, 0, 1);
    
    NSString* vertexShaderPathname = [[NSBundle mainBundle] pathForResource:@"vertex" ofType:@"vsh"];
    NSString* fragmentShaderPathname = [[NSBundle mainBundle] pathForResource:@"fragment3" ofType:@"fsh"];
    GLuint program = [glView glVertex:[NSString stringWithContentsOfFile:vertexShaderPathname
                                                                encoding:NSUTF8StringEncoding
                                                                   error:nil]
                             fragment:[NSString stringWithContentsOfFile:fragmentShaderPathname
                                                                encoding:NSUTF8StringEncoding
                                                                   error:nil]];
    
    _time = glGetUniformLocation(program, "time");
    _timeValue = 10.0f;
    glUniform1f(_time, _timeValue);
    
    _resolution = glGetUniformLocation(program, "resolution");
    _resolutionValue[0]= NSWidth(glView.frame);
    _resolutionValue[1]= NSHeight(glView.frame)-100;
    glUniform2fv(_resolution, 1, _resolutionValue);
    
    _mouse = glGetUniformLocation(program, "mouse");
    _mouseValue[0] = 1.0f;
    _mouseValue[1] = 1.0f;
    glUniform2fv(_mouse, 1, _mouseValue);
}

- (void) glDraw:(NSOpenGLView*)view {
    glClear( GL_COLOR_BUFFER_BIT );
    
    glBegin(GL_QUADS);
    glVertex3f(-1, -1, 0);
    glVertex3f(-1, 1, 0);
    glVertex3f(1, 1, 0);
    glVertex3f(1, -1, 0);
    glEnd();

    _timeValue += 0.05f;
    glUniform1f(_time, _timeValue);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _resolutionValue = (GLfloat*)malloc(2*sizeof(GLfloat));
    memset(_resolutionValue, 0, 2*sizeof(GLfloat));
    _mouseValue = (GLfloat*)malloc(2*sizeof(GLfloat));
    memset(_mouseValue, 0, 2*sizeof(GLfloat));
    
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
            
            [NSTimer scheduledTimerWithTimeInterval:1/2 target:self selector:@selector(nsAnimate:) userInfo:view repeats:YES];
            
        } else {
            //OpenGL Rapid view
            //Block
//            NSOpenGLView* glView = [NSOpenGLView withBlock:^(NSOpenGLView *nsuiView) {
//                glClear( GL_COLOR_BUFFER_BIT );
//                glBegin(GL_QUADS);
//                glVertex3f(-1, -1, 0);
//                glVertex3f(-1, 1, 0);
//                glVertex3f(1, 1, 0);
//                glVertex3f(1, -1, 0);
//                glEnd();
//                
//                _timeValue += 0.05f;
//                glUniform1f(_time, _timeValue);
//            } frame:mainView.frame superDraw:NO];
//            [glView mouseDraggedWithBlock:^(NSOpenGLView* view, NSEvent *event) {
//                _mouseValue[0] = [event locationInWindow].x/NSWidth(glView.frame);
//                _mouseValue[1] = [event locationInWindow].y/NSHeight(glView.frame);
//                glUniform2fv(_mouse, 1, _mouseValue);
//                [view setNeedsDisplay:YES];
//            }];            
            
            //Method
            NSOpenGLView* glView = [NSOpenGLView withMethod:@selector(glDraw:)
                                                     target:self
                                                      frame:mainView.frame
                                                  superDraw:NO];
            [glView glSetWithMethod:@selector(GLSet:) target:self];
            [glView mouseDownWithMethod:@selector(mouseDown:event:) target:self];
            [glView mouseDraggedWithMethod:@selector(mouseDragged:event:) target:self];
            [mainView addSubview:glView];
            float frameRate = 1.0f/30.0f;
            [NSTimer scheduledTimerWithTimeInterval:frameRate
                                             target:self
                                           selector:@selector(glAnimate:)
                                           userInfo:glView
                                            repeats:YES];
        }
    };
    
    //NSView 0
    //NSOpenGLView 1
    test(1);
}

- (void) glAnimate:(NSTimer*)timer {
    [timer.userInfo setNeedsDisplay:YES];
}

- (void) nsAnimate:(NSTimer*)timer {
    [timer.userInfo setNeedsDisplay:YES];
}

@end
