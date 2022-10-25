//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float dur;

void main()
{
	vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 new_col = base_col;
	
	new_col.rgb = clamp(new_col.rgb + (dur / 60.0), 0.0, 1.0);
	
    gl_FragColor = new_col;
}
