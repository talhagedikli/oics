//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 base_col =  texture2D( gm_BaseTexture, v_vTexcoord );
	base_col.rgb = vec3(1.0);
	
	
    gl_FragColor = v_vColour * base_col;
}
