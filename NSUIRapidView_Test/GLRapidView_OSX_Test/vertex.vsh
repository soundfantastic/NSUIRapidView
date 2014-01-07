//
//  Shader.vsh
//  NSUIRapidViewGL_IOS_Test
//
//  Created by Dragan Petrovic on 26/12/2013.
//  Copyright (c) 2013 Dragan Petrovic. All rights reserved.
//

void main() {
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}