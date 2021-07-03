/// @description
draw_sprite_ext(sprite_index, image_index, iotaX, iotaY, xScale * facing, yScale,
				image_angle, image_blend, image_alpha);

//drawGrid(gridPos, [ -1, 1, 2], [0]);
//drawGrid(gridPos, [-1, 1], [-1, 0, 1]);

//drawGridV2(gridPos, area);
var _pos	= gridPos;
var _arr	= area;
var gm		= 4;
var x1, x2, y1, y2;
var col = c_gray_cloud;

var i = 0; repeat(array_length(distance))
{
	x1 = distance[i][0];
	x2 = distance[i][0] + 1;
	y1 = distance[i][1];
	y2 = distance[i][1] + 1;
	
	var j = 0; repeat(ds_list_size(collisions))
	{
		if (collisions[| j].gridPos.x == x1) && (collisions[| j].gridPos.y == y1)
		{
			col = C_CRIMSON;
			break;
		}
		else 
		{
			col = c_white;
		}
		j++;
	}
	CleanRectangle(x1 * GRID_W + gm, y1 * GRID_H + gm, x2 * GRID_W - gm, y2 * GRID_H - gm).Blend(col, 1).Border(2, c_white, 0.8).Rounding(4).Draw();
	i++;
}



