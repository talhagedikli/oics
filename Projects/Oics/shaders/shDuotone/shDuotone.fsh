//
// Simple passthrough fragment shader
// uses rgb on the light object to duotone
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 duo_col;

void main()
{
	vec4 base_col = texture2D( gm_BaseTexture, v_vTexcoord );
	
	//vec3 duo_col = vec3(duo_col_r, duo_col_b, duo_col_b); already a vec3
	
	float grey = dot(base_col.rgb, vec3(0.299, 0.587, 0.114));
	
    gl_FragColor = v_vColour * vec4(vec3(grey) * duo_col, base_col.a);
}
