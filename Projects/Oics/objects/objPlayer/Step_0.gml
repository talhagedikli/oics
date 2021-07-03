checkCollisions();
state.step();


//x = clamp(bbox_left, 0, room_width);
	
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);
check_collisions_pixel_perfect();
xPos = x;
yPos = y;

log(ds_list_size(collisions));








 
