state.step();


//x = clamp(bbox_left, 0, room_width);
	
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);
xPos = x;
yPos = y;

