/// @description 
if (room == rTitle) { // TITLE ROOM
	if (layer_exists("Sky")) {
		var sky = layer_background_get_id("Sky");
		layer_background_alpha(sky, abs(sin(current_time/10000)) * 0.7);
		layer_background_xscale(sky, 0.1);
		layer_background_yscale(sky, 0.1);
	}

	
}
else if (room == rWorld) { // WORLD ROOM
	

	
}