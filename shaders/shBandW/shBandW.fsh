//
// Simple passthrough fragment shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	
    vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
    float lum = dot(color.rgb, vec3(0.299, 0.587, 0.114));
	
	//if (color.r + color.g + color.b < 0.5) {
	//	color.rgb = vec3(0.0);
	//} else {
	//	color.rgb = vec3(1.0);
	//}
	if (lum < 0.175) { 
		color.rgb = vec3(0.0);
	} else {
		color.rgb = vec3(1.0);
	}
	
    gl_FragColor = color;
}
