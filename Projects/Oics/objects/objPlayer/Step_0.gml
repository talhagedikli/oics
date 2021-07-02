checkCollisions();
state.step();


//x = clamp(bbox_left, 0, room_width);
	
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);
check_collisions_pixel_perfect();
xPos = x;
yPos = y;

var _pos	= gridPos;
var _arr	= area;
var gm		= 4;
var x1, x2, y1, y2;
var bl		= noone;
var i = 0; repeat(array_length(_arr))
{

	var xp = _pos.x * GRID_W;
	var yp = _pos.y * GRID_H;
	var xg = _arr[i][0] * GRID_W;
	var yg = _arr[i][1] * GRID_H;
	var safe = true;
	x1		= min(xg);
	x2		= max(xg);
	y1		= min(yg);
	y2		= max(yg);
	bl		= collision_line(xp + gm + xg, yp + gm + yg, xp - gm + GRID_W + xg, yp - gm + GRID_H + yg, objBlock, false, true);
	var j = 0; repeat(ds_list_size(collisions))
	{
		if (ds_list_find_value(collisions, j) == bl)
		{
			safe = false;
		}
		j++;
	}
	if (safe)
		collision_line_list(xp + gm + xg, yp + gm + yg, xp - gm + GRID_W + xg, yp - gm + GRID_H + yg, objBlock, false, true, collisions, false);
	//var j = 0; repeat(ds_list_size(collisions))
	//{
		
	//	if (ds_list_find_value(collisions, j) == bl)
	//	{
	//		safe = false;
	//	}
	//	j++;
	//}
	//if (safe && bl != noone)
	//{
	//	ds_list_add(collisions, bl);
	//}
	
	i++;	
}




log(ds_list_size(collisions));