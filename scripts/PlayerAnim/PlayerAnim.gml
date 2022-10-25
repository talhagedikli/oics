/// @description
//checks one time(create event)
function animation_init()
{
	//initialize variables for drawing, and animation.
	//draw
	sprite = sprite_index;
	frame  = 0;
	xPos   = x;
	yPos   = y;
	xScale = 1;
	yScale = 1;
	angle  = 0;
	color  = c_white;
	alpha  = 1

	//animation
	frameSpeed = 0.15;
	facing = 1;
	lastSprite = sprite;
	
	/*key mapping
	keyboard_set_map(vk_up, ord("W"));
	keyboard_set_map(vk_left, ord("A"));
	keyboard_set_map(vk_down, ord("S"));
	keyboard_set_map(vk_right, ord("D"));
	*/
}

/// @description
function frame_reset(){
	if(floor(frame) >= sprite_get_number(sprite))
	{
	    frame = 0;
	}

}

/// @func		animation_end()
/// @returns	{bool}						Whether sprite_index has finished animating or not
/// @author		Minty Python
function animation_end() {
	return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}

// @description squash and stretch
function squash_stretch(_xScale, _yScale) {
	xScale = _xScale;
	yScale = _yScale;
}







