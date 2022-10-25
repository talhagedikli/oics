//
// duotone stylized fragment shader
//
varying vec2 v_vTexcoord;
//varying vec4 v_vColour;

uniform vec3 duo_col_light;
uniform vec3 duo_col_dark;

uniform float crush;

void main()
{
	vec4 base_col = texture2D( gm_BaseTexture, v_vTexcoord );
	float grey = dot(base_col.rgb, vec3(0.299, 0.587, 0.114));
	grey = smoothstep(crush, 1.0 - crush, grey);
	vec3 out_col = mix(duo_col_dark, duo_col_light, grey);
	
    gl_FragColor = vec4(out_col, base_col.a);
    //gl_FragColor = v_vColour * vec4(out_col, base_col.a);
}
/*HOW TO USE
create:
uniDuoColLight	= shader_get_uniform(shDuotoneStylized, "duo_col_light");
uniDuoColDark	= shader_get_uniform(shDuotoneStylized, "duo_col_dark");
uniCrush		= shader_get_uniform(shDuotoneStylized, "crush");

duoColLight = [1.2, 1.2, 0.6];
duoColDark	= [0.1, -0.4, 0.3];

draw:
shader_set(shDuotoneStylized);
shader_set_uniform_f_array(uniDuoColLight, hue_shift_rgb(duoColLight, global.slider0));
shader_set_uniform_f_array(uniDuoColDark, hue_shift_rgb(duoColDark, global.slider1));
shader_set_uniform_f(uniCrush, global.slider2 * 0.5);

*/