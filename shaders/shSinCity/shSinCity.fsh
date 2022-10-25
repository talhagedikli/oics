//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


//void main()
//{
//	vec4 base_col	= texture2D( gm_BaseTexture, v_vTexcoord );
//	base_col.rgb = pow(base_col.rgb, vec3(0.45));
	
//	float grey = dot(base_col.rgb, vec3(0.333));
	
//	float weight = smoothstep(0.1, 0.25, base_col.r - grey);
	
//	grey = pow(grey * 1.1, 2.0);
	
//	base_col.rgb = mix(vec3(grey), base_col.rgb * vec3(1.1, 0.5, 0.5), weight);

//	gl_FragColor = v_vColour * vec4(pow(base_col.rgb, vec3(2.2)), base_col.a);
//}
void main()
{
	vec4 base_col	= texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 out_col	= base_col;
	//colorin is the original color of the pixel, colorout the altered color
 
	if((base_col.g + base_col.b) < base_col.r )
	{
		out_col.r = base_col.r;
		out_col.g = 0.0;
		out_col.b = 0.0;
 
	}
	else
	{
		out_col.rgb = vec3(dot(base_col.rgb, base_col.rgb ) * dot(base_col.rgb, vec3(2.0, 1.0, 2.0)));
	}

	gl_FragColor = v_vColour * vec4(out_col.r, out_col.g, out_col.b, base_col.a);
}
