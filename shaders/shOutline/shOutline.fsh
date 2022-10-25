//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D lights;

uniform float pixelW;
uniform float pixelH;

void main()
{
	vec3 col	= texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
	float alpha	= texture2D( gm_BaseTexture, v_vTexcoord ).a;
	
	// handle lights:
    vec3 lights_col = texture2D( lights, v_vTexcoord ).rgb;
	//grey			= dot(lights_col, vec3(0.333));

	
	vec2 offsetx;
	offsetx.x	= pixelW;
	
	vec2 offsety;
	offsety.y	= pixelH;
	
	alpha		+= ceil( texture2D( gm_BaseTexture, v_vTexcoord - offsetx).a );
	col.rgb		= texture2D( gm_BaseTexture, v_vTexcoord - offsetx).rgb + lights_col;
	
	
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a = alpha;
	gl_FragColor.rgb = col;
}
