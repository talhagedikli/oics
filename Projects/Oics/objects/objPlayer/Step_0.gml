checkCollisions();
state.step();


//x = clamp(bbox_left, 0, room_width);
	
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);
check_collisions_pixel_perfect();
xPos = x;
yPos = y;

log(ds_list_size(collisions));



if (keyboard_check_pressed(ord("E")))
{
	if (ds_list_size(collisions) > 0)
	{
		instance_destroy(collisions[| irandom(ds_list_size(collisions) - 1)]);
	}
}

if (gridMeeting(gridPos.x, gridPos.y, objBlock))
{
	show("there is a block a pixel away");
}



 
