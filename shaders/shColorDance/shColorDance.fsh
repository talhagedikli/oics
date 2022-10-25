//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_resolution;
uniform float u_time;

//void main()
//{
//    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
//}

void main(){
	vec4 baseCol	= texture2D( gm_BaseTexture, v_vTexcoord );
	
    vec2 coord 		= 7.0 * gl_FragCoord.xy / u_resolution;

    for (int n = 1; n < 8; n++){
        float i = float(n);
        coord += vec2(0.7 / i * sin(i * coord.y + u_time + 0.3 * i) + 0.8, 
                0.4 / i * sin(coord.x + u_time + 0.3 * i) + 1.6);
    }
	
    vec3 color		= vec3(0.5 * sin(coord.x) + 0.5, 0.5 * sin(coord.y) + 0.5, sin(coord.x + coord.y));
	
	vec3 outCol		= mix(baseCol.rgb, color, 0.3);
	
	
    gl_FragColor 	= vec4(outCol, 1.0);
}