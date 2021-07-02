//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float brightness;
uniform float contrast;

void main()
{
	vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	base_col.rgb = (base_col.rgb - 0.5) * contrast + 0.5;
	float grey = dot(base_col.rgb, vec3(0.299, 0.587, 0.114));
	base_col.rgb = mix(base_col.rgb, vec3(grey), max(contrast - 1.0, 0.0) * 0.25);
	base_col.rgb = base_col.rgb + brightness * (1.0 + contrast * 0.5);
	
    gl_FragColor = base_col;
}