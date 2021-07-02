/// @
//width and height 384*216
viewWidth	=	1920/5;
viewHeight	=	1080/5;
windowScale =	3;

//state
state = states.normal;

//set window size
window_set_size(viewWidth*windowScale, viewHeight*windowScale);
alarm[0] = 1;

//re-set surface and gui 
surface_resize(application_surface, viewWidth*windowScale, viewHeight*windowScale);
display_set_gui_size(viewWidth*windowScale, viewHeight*windowScale);


//shake
shake = false;
shake_time = 0;
shake_magnitude = 0;
shake_fade = 0.25;

//
enum cam {
	normal,
	cell 
}



