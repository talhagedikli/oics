/// @description 
if (room == rTitle) { // TITLE ROOM

	
}
else if (room == rWorld) { // WORLD ROOM
	
	if (layer_exists("Sky")) {
		var sky = layer_background_get_id("Sky");
		layer_background_xscale(sky, 0.7);
		layer_background_yscale(sky, 0.7);
	}
	
}