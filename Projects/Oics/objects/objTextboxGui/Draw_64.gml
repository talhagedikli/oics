//general variables  and calculations
//gui width and height
var _xStart = 32;
var _yStart = 3*(GUI_H/4);
var _xEnd = GUI_W-32;
var _yEnd = GUI_H-16;

//textbox's width and height
var _boxW = abs(_xEnd - _xStart);
var _boxH = abs(_yEnd - _yStart);

//some colors
var _b	= c_black;
var _w = c_white;

//x margins
var _xMargin = 16;

//y margins
var _fntSize = font_get_size(fntText);
var _nMargin = 16;
var _tMargin = (2*_nMargin) + _fntSize;

//draw textbox

//classic rectangle textbox
//draw_rectangle_color(_xStart,_yStart,_xEnd,_yEnd, _w, _w, _w, _w, false);
//draw_rectangle_color(_xStart+2, _yStart+2, _xEnd-2, _yEnd-2, _b,_b,_b,_b, false);

//roundrect textbox

draw_set_alpha(0.7);
draw_roundrect_color(_xStart+2, _yStart+1, _xEnd-2, _yEnd-1, _b, _b, false);
draw_set_alpha(1);

//draw text

//set font to text font
draw_set_font(fntText);

//calculate the strings length and character speed
if(charCount < string_length(text[page]))
{
	charCount += charSpd;
}

textPart = string_copy(text[page], 1, charCount);

//draw creator's name
draw_set_color(c_red);
draw_text(_xStart + _xMargin ,_yStart + _nMargin, name);
draw_set_color(c_white);

//draw the text itself
draw_text_ext(_xStart + _xMargin, _yStart + _tMargin, textPart, stringH*2, _boxW - 2*_xMargin);




