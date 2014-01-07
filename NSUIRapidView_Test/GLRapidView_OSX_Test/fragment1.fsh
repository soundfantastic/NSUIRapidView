#ifdef GL_ES
precision mediump float;
#endif
#define pi 3.1416
uniform vec2 mouse;
uniform vec2 resolution;

const float escala = 3.7;
vec2 mouseAjustado;
vec2 fragCoordAjustado;

float distanciaEntre2Puntos(vec2 p1, vec2 p2) {
    return  sqrt(((p2.x-p1.x)*(p2.x-p1.x))+((p2.y-p1.y)*(p2.y-p1.y)));
}

void dibujarPunto(vec2 punto, vec4 color) {
    if (punto.x >= fragCoordAjustado.x    &&
        punto.x < fragCoordAjustado.x+0.1 &&
        punto.y >= fragCoordAjustado.y    &&
        punto.y < fragCoordAjustado.y+0.1) {
            gl_FragColor= color;
    }
}

vec2 calcularAtraccion(vec2 A, vec2 V) {
	float d = sqrt(((A.x-V.x)*(A.x-V.x))+((A.y-V.y)*(A.y-V.y)));
	if(d<1.0)d=1.0;
	vec2 S= V+((A-V)/(d*d));
	return S;
}

void main( void ) {
	mouseAjustado = vec2((escala*mouse.x*(resolution.x/resolution.y)),(escala*mouse.y) );
	fragCoordAjustado = (escala/resolution.y)*gl_FragCoord.xy;
	
	vec2 vertice1 = mouseAjustado;
	vec2 atractor = vec2((resolution.x/resolution.y)*(escala/2.0),escala/2.0);
	float intensidad=0.0;
	intensidad += 0.4/distanciaEntre2Puntos(atractor,fragCoordAjustado);
	vec2 v[8];
	for(int i=0; i<8;i++){
        v[i]= vec2((mouseAjustado.x+(1.0*cos(float(i)*2.0*pi/8.0))),mouseAjustado.y+(1.0*sin(float(i)*2.0*pi/8.0)));
        
        v[i]= calcularAtraccion(atractor,v[i]);
		dibujarPunto( v[i], vec4(0,0,1,1));
        intensidad+= 0.06/distanciaEntre2Puntos( v[i],fragCoordAjustado);
        
	}
	dibujarPunto( atractor, vec4(0,0,1,1));
	for(int i=0; i<8;i++){
        gl_FragColor = smoothstep(0.8, 1.0, vec4(1,1,1,1)*intensidad);
	}	
}