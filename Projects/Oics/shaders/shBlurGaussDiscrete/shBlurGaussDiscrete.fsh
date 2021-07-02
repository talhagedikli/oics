//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float blur_steps;
uniform vec2 texel_size;
uniform float sigma;
uniform vec4 uvs;

float weight(vec2 pos) { //gauss 2D
	return exp(-(pos.x * pos.x + pos.y * pos.y) / (2.0 * sigma * sigma));
}
	


void main()
{
	highp vec4 blurred_col = vec4(0.0);
	
	vec2 offset, sample;
	float sample_weight;
	float total_weight = 0.0;
	float kernel = 2.0 * blur_steps + 1.0;
	
	
	for (offset.x = -blur_steps; offset.x <= blur_steps; offset.x ++) {
		for (offset.y = -blur_steps; offset.y <= blur_steps; offset.y ++) {
			sample_weight =	weight(offset / kernel);
			total_weight += sample_weight;
			
			
			sample = clamp(v_vTexcoord + offset * texel_size, uvs.xy, uvs.zw);
			blurred_col += texture2D( gm_BaseTexture, sample ) * sample_weight;
		}
	}
		
    gl_FragColor = v_vColour * blurred_col / total_weight;
	
}
