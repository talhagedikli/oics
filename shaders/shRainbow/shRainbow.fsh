//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float x_pos;
uniform float y_pos;

float absin(float _time) {
	return abs(sin(_time));	
}

float abcos(float _time) {
	return abs(cos(_time));	
}

vec2 nst(float _x, float _y) {
	
	return vec2(normalize(_x), normalize(_y));
	
}

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}


void main()
{
	vec4 base_col	= texture2D( gm_BaseTexture, v_vTexcoord );
	vec2 bp			= vec2(x_pos, y_pos);
	bp				= normalize(bp);
	
	base_col.rgb	= vec3(1., 0.5, 1.);
	
	
    gl_FragColor = v_vColour * base_col;
}
