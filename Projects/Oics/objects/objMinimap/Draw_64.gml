/// @description
if (global.showMinimap)
{
	alpha = flerp(alpha, 1, 0.1);

}
else
{
	alpha = flerp(alpha, 0, 0.2);
}

// General variables
var mapSize = 100;
var gap = 10;
var radius = 2;
if (!surface_exists(minimap))
{
	minimap = surface_create(mapSize, mapSize);
}
surface_set_target(minimap);
draw_clear_alpha(c_white, 0);
if (minimapType == mmTypes.stable)
{ // STABLE TYPE
	draw_set_color(c_white);
	draw_set_circle_precision(64);
	draw_set_alpha(0.8);
	draw_roundrect_ext(0, 0, mapSize, mapSize, 20, 20, false);
	with(objParMinimap)
	{
		draw_set_color(c_black);
		draw_set_alpha(1);
		draw_circle(remap(x, 0, room_width, 0, mapSize), y / room_height * mapSize, radius, false);
		//draw_point(lerp(0, mapSize, x/room_width), lerp(0, mapSize, y/room_height));
	}
}
else if (minimapType == mmTypes.dynamic)
{ // DYNAMIC TYPE
	CleanBatchBegin();
	draw_set_color(c_white);
	draw_set_alpha(0.8);
	var pX = (objPlayer.x / room_width) * mapSize;
	var pY = (objPlayer.y / room_height) * mapSize;
	var minScl = 2; // Minimap downscale
	CleanCircle(mapSize / 2, mapSize / 2, mapSize / 2).Blend(c_white, 0.8).Border(2, C_ONYX, 1.0).Draw();
	with(objParMinimap)
	{
		draw_set_color(C_CRIMSON);
		draw_set_alpha(1);
		CleanCircle(mapSize / 2, mapSize / 2, radius).Blend(C_CRIMSON, 1).Draw();
	}
	CleanBatchEndDraw();
	// Draw Blocks
	with(objBlock)
	{
		draw_set_color(c_dkgray);
		draw_set_alpha(1);
		if (point_in_circle(((x / room_width) * mapSize) * minScl, ((y / room_height) * mapSize) * minScl, pX * minScl, pY * minScl, mapSize / 2 - 5))
		{ // Checks if block in circle
			// Drawing blocks but their positions are in view of player
			draw_sprite_ext(sprite_index, image_index, (((x / room_width) * mapSize) - pX) * minScl + (mapSize / 2),
				(((y / room_height) * mapSize) - pY) * minScl + (mapSize / 2), image_xscale * (mapSize / room_width), image_yscale * (mapSize / room_height), 0, c_dkgray, 1);
		}
	}
}
// Reset values and surface and draw surface
draw_set_color(c_white);
draw_set_alpha(1);
surface_reset_target();
// Draw the surface to resized gui
var resize = 1;
var miniX = GUI_W - gap - mapSize * resize;
var miniY = GUI_H - gap - mapSize * resize;
//surface_resize(minimap, mapSize*resize, mapSize*resize);
draw_surface_ext(minimap, miniX, miniY, 1, 1, 0, c_white, alpha);