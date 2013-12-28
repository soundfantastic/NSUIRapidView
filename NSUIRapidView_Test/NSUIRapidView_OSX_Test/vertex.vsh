//
//  Shader.vsh
//  NSUIRapidViewGL_IOS_Test
//
//  Created by Dragan Petrovic on 26/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

uniform float modulation;
void main(void){
    float rad_angle = modulation*3.14159265358979323846264/180.0;
    vec4 a = gl_Vertex;
    vec4 b = a;
    b.x = a.x*cos(rad_angle) - a.y*sin(rad_angle);
    b.y = a.y*cos(rad_angle) + a.x*sin(rad_angle);
    gl_Position = gl_ModelViewProjectionMatrix*b;
}

