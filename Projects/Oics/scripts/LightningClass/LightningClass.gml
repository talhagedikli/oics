function hue_shift_rgb(_col, _shift) {
///@description	Shifts hue of an rgb color even if the values are > 1
///				White is (1, 1, 1), not (255, 255, 255)!
///@param color_array[r|g|b[0-1+]] as an array with r, g & b
///@param shift[0-1]

var in_col  = _col;
var max_val = max(in_col[0], in_col[1], in_col[2]);

// normalize:
var out_col_array = [in_col[0] / max_val, in_col[1] / max_val, in_col[2] / max_val];

// make color and get hsv:
var out_col_rgb = make_color_rgb(out_col_array[0] * 255, out_col_array[1] * 255, out_col_array[2] * 255);
var hue = color_get_hue(out_col_rgb);
var sat = color_get_saturation(out_col_rgb);
var val = color_get_value(out_col_rgb);

// shift hue:
hue += _shift * 255;
if (hue > 255) hue -= 255;

// apply hue:
out_col_rgb = make_color_hsv(hue, sat, val);

// denormalize
var r = color_get_red(out_col_rgb) / 255;
var g = color_get_green(out_col_rgb) / 255;
var b = color_get_blue(out_col_rgb) / 255;

out_col_array = [r * max_val, g * max_val, b * max_val];

// return
return out_col_array;



}
	
function add_keytime(_R, _G, _B, _con, _sat, _brt, _popStrength, _popThreshold) {

if (is_undefined(color[0]))
{
	color[0] = _R / 255;
	color[1] = _G / 255;
	color[2] = _B / 255;
}
	
if (is_undefined(conSatBrt[0]))
{
	conSatBrt[0] = _con;
	conSatBrt[1] = _sat;
	conSatBrt[2] = _brt;
	conSatBrt[3] = _popStrength;
	conSatBrt[4] = _popThreshold;
		
}
//example values
	#region colours and con_sat_brt:
//add_keytime(010, 070, 200, 0.7, 0.6, 0.00);	// mid night
//add_keytime(010, 080, 220, 0.8, 0.9, 0.00);	// late night
//add_keytime(220, 200, 175, 1.1, 1.3, 0.05);	// dawn
//add_keytime(245, 235, 190, 1.1, 1.1, 0.10);	// morning
//add_keytime(255, 250, 230, 1.3, 0.9, 0.15);	// noon
//add_keytime(250, 240, 200, 1.4, 1.1, 0.15);	// late after-noon
//add_keytime(215, 150, 165, 1.4, 1.3, 0.20);	// dusk
//add_keytime(010, 080, 220, 0.9, 0.9, 0.00);	// early night
#endregion

	#region colours, con_Sat_brt & pop-values:
//add_keytime(010, 070, 200, 0.7, 0.6, 0.00, 2.50, 0.67);	// mid night
//add_keytime(010, 080, 220, 0.8, 0.9, 0.00, 2.00, 0.75);	// late night
//add_keytime(220, 200, 175, 1.1, 1.3, 0.05, 0.80, 0.80);	// dawn
//add_keytime(250, 235, 200, 1.2, 1.1, 0.10, 0.00, 1.00);	// morning
//add_keytime(255, 250, 230, 1.3, 0.9, 0.15, 0.00, 1.00);	// noon
//add_keytime(250, 240, 200, 1.4, 1.1, 0.15, 0.00, 1.00);	// late after-noon
//add_keytime(215, 150, 165, 1.5, 1.4, 0.25, 0.80, 0.80);	// dusk
//add_keytime(010, 080, 220, 0.9, 0.9, 0.00, 2.00, 0.75);	// early night
#endregion

	#region Overlay Sytem:
//add_keytime(030,	120,	225,	0.60,	1.00,  -0.20,	0.80,	0.65);	// 00h
//add_keytime(040,	125,	215,	0.65,	0.90,  -0.20,	0.70,	0.65);	// 02h
//add_keytime(080,	080,	185,	0.80,	0.60,  -0.15,	0.20,	0.80);	// 04h
//add_keytime(125,	070,	175,	1.00,	0.85,  -0.10,  -0.50,	0.60);	// 06h
//add_keytime(160,	145,	100,	1.20,	0.65,  -0.03,	0.00,	1.00);	// 08h
//add_keytime(128,	128,	128,	1.00,	1.00,	0.00,	0.00,	1.00);	// 10h
//add_keytime(128,	128,	128,	1.20,	0.85,	0.05,	0.00,	1.00);	// 12h
//add_keytime(128,	128,	128,	1.00,	1.00,	0.00,	0.00,	1.00);	// 14h
//add_keytime(140,	130,	120,	1.10,	0.80,	0.00,	0.00,	1.00);	// 16h
//add_keytime(145,	120,	090,	1.10,	0.75,	0.00,	0.00,	1.00);	// 18h
//add_keytime(150,	060,	190,	1.25,	0.70,  -0.05,  -0.50,	0.60);	// 20h
//add_keytime(080,	080,	185,	0.80,	0.60,  -0.15,	0.20,	0.80);	// 22h
#endregion
	

}

