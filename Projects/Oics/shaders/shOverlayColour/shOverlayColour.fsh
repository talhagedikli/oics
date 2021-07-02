//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
//varying vec4 v_vColour;

uniform vec3 col;

void main()
{
	vec4 base_col = texture2D( gm_BaseTexture, v_vTexcoord );
	//if statement
	float lum = dot(base_col.rgb, vec3(0.299, 0.587, 0.114));
	
	if (lum > 0.5)
	{
		base_col.rgb = 1.0 - (1.0 - 2.0 * (base_col.rgb - 0.5)) * (1.0 - col);
	}
	else
	{
		base_col.rgb = (2.0 * base_col.rgb) * col;
	}
	
	//insline if statement
	//float lum = dot(base_col.rgb, vec3(0.299, 0.587, 0.114));
	//base_col.rgb = lum > 0.5 ? 1.0 - (1.0 - 2.0 * (base_col.rgb - 0.5)) * (1.0 - col) : base_col.rgb = (2.0 * base_col.rgb) * col;
	
	gl_FragColor = base_col;
}
