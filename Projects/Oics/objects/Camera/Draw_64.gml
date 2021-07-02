/// @description
if (smooth && surface_exists(viewSurf)) {
	var ax = camera_get_view_x(VIEW) - camX;
	var ay = camera_get_view_y(VIEW) - camY;
	draw_surface(viewSurf, ax, ay);
}