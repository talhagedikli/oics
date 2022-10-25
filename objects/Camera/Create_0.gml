//width and height 480*270
viewWidth		=	1920/2;
viewHeight		=	1080/2;
windowScale		=	3/2;

following		= instance_exists(objPlayer) ? objPlayer : noone;

//spd variables
followSpd		= 0.1;
zoomSpd			= 0.05;

//cam width and height
defaultW = viewWidth;
defaultH = viewHeight;

//first set to default
camW = defaultW;
camH = defaultH;

camX = camera_get_view_x(VIEW);
camY = camera_get_view_y(VIEW);

//to switch target
newW = 0;
newH = 0;

//camera target
if (instance_exists(following)) 
{
	targetX	= following.x - camW/2;
	targetY	= following.y - camH/2;
}
//set window size
window_set_size(viewWidth*windowScale, viewHeight*windowScale);
alarm[0] = 1;

//re-set surface and gui 
surface_resize(application_surface, viewWidth*windowScale, viewHeight*windowScale);
display_set_gui_size(viewWidth*windowScale, viewHeight*windowScale);

viewSurf	= -1;
smooth		= false;

application_surface_enable(!smooth);
//shake
shake			= false;
shake_time		= 0;
shake_magnitude = 0;
shake_fade		= 0;

//enums 
enum camStates 
{
	normal,
	cell,
	zoom
}

// Methods
applyScreenShake = function () 
{
	if (shake)
	{
		//reduce shake time by 1(every step)
		shake_time -= 1;
			
		//calculate shake magnitude
		var _xval = choose(-shake_magnitude, shake_magnitude); 
		var _yval = choose(-shake_magnitude, shake_magnitude);
			
		//apply the shake
		camX = camX + _xval;
		camY = camY + _yval;
			
		if (shake_time <= 0) 
		{
			//if shake time is zero, shake fade
			shake_magnitude -= shake_fade; 

			if (shake_magnitude <= 0) 
			{
				//if shake fade is zero, turn shake of
			    shake = false; 
			} 
		}
	}
	
}

updateCameraSize = function (_w, _h) 
{
	camW = flerp(camW, _w, zoomSpd);
	camH = flerp(camH, _h, zoomSpd);
}

state = new SnowState("cell");

state.history_enable(true);
state.set_history_max_size(5);

state.add("normal", {
	enter: function()
	{
		
	},
	step: function()
	{
		if (instance_exists(following))
		{
			var xTo, yTo;
			xTo = round(following.x) - (camW / 2);
			yTo = round(following.y) - (camH / 2);
			//camX = abs(difX) < EPSILON ? targetX : lerp(camX, targetX, followSpd);
			camX = flerp(camX, xTo, followSpd, 0.000001);
			camY = flerp(camY, yTo, followSpd, 0.000001);
			//camY = abs(difY) < EPSILON ? targetY : lerp(camY, targetY, followSpd);
			applyScreenShake();
		}		
	},
	leave: function()
	{
		
	}
});

state.add("cell", {
	enter: function()
	{
		
	},
	step: function()
	{
		if (instance_exists(following))
		{
			var xTo, yTo;
			xTo = (following.x div viewWidth) * viewWidth;
			yTo = (following.y div viewHeight) * viewHeight;
			var difX, difY;
			difX = (xTo - camX);
			difY = (yTo - camY);
			camX = abs(difX) < 1 ? xTo : camX + difX / 15;
			camY = abs(difY) < 1 ? yTo : camY + difY / 15;
		}
		//screen shake script to apply it
		applyScreenShake();		
	},
	leave: function()
	{
		
	}
});

state.add("zoom", {
	enter: function()
	{
		
	},
	step: function()
	{
		if (instance_exists(following))
		{
			//if zoomed in, make camera smaller
			newW = defaultW / 2;
			newH = defaultH / 2;
			//camW = flerp(camW, newW, zoomSpd);
			//camH = flerp(camH, newH, zoomSpd);
			//go to who you are focused to
			camX = flerp(camX, targetX, followSpd);
			camY = flerp(camY, targetY, followSpd);
		}		
	},
	leave: function()
	{
		
	}
});



//global.clock.add_cycle_method(function()
//{
//	if (global.zoom)
//	{
//		updateCameraSize(newW, newH);
//	}
//	else
//	{
//		updateCameraSize(defaultW, defaultH);
//	}	
	
//	state.step();
	
//	camX = clamp(camX, 0, room_width - camW);
//	camY = clamp(camY, 0, room_height - camH);
//	camera_set_view_size(VIEW, camW, camH);

//	if keyboard_check_pressed(ord("S")) 
//	{
//		smooth = !smooth;
//		application_surface_enable(!smooth);

//		var pad = smooth ? 1 : 0;
//		camera_set_view_size(VIEW, camW + pad, camH + pad);	
//	}

//	//apply the camera's positions and size

//	camera_set_view_pos(VIEW, camX, camY);


//	 //Smooth camera
//	if (smooth) {
//		if (!surface_exists(viewSurf)) {
//			viewSurf = surface_create(viewWidth * windowScale + 1, viewHeight * windowScale + 1);
//		}
//		view_surface_id[0] = viewSurf;
//	} else {
//		if (surface_exists(viewSurf)) {
//			surface_free(viewSurf);
//			viewSurf = -1;
//		}
//		view_surface_id[0] = -1;
	
//	}
//	//track the transition layer
//	if (layer_sequence_exists("transitions", global.sequenceLayer))
//	{
//		layer_sequence_x(global.sequenceLayer, camX);
//		layer_sequence_y(global.sequenceLayer, camY);
//	}	
	
	
	
	
//});



