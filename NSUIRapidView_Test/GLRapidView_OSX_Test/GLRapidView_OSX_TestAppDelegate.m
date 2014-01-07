//
//  GLRapidView_OSX_TestAppDelegate.m
//  GLRapidView_OSX_Test
//
//  Created by Dragan Petrovic on 06/01/2014.
//  Copyright (c) 2014 Dragan Petrovic. All rights reserved.
//

#import "GLRapidView_OSX_TestAppDelegate.h"
#import "NSOpenGLView+DynamicDraw.h"
#import "NSOpenGLView+MouseEvents.h"
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl.h>

@interface GLRapidView_OSX_TestAppDelegate () 
@property (nonatomic, assign)   GLint       time;
@property (nonatomic, assign)   GLint       resolution;
@property (nonatomic, assign)   GLint       mouse;
@property (nonatomic)           GLfloat     timeValue;
@property (nonatomic)           GLfloat*    resolutionValue;
@property (nonatomic)           GLfloat*    mouseValue;
@end

@implementation GLRapidView_OSX_TestAppDelegate

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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    _resolutionValue = (GLfloat*)malloc(2*sizeof(GLfloat));
    memset(_resolutionValue, 0, 2*sizeof(GLfloat));
    _mouseValue = (GLfloat*)malloc(2*sizeof(GLfloat));
    memset(_mouseValue, 0, 2*sizeof(GLfloat));
    
    _window.backgroundColor = [NSColor blackColor];
    NSView* mainView = _window.contentView;
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

- (void) glAnimate:(NSTimer*)timer {
    [timer.userInfo setNeedsDisplay:YES];
}

@end
