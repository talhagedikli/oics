/// @description
draw_sprite_ext(sprite_index, image_index, x, y, xScale * facing, yScale,
				image_angle, image_blend, image_alpha);

//drawGrid(gridPos, [ -1, 1, 2], [0]);
//drawGrid(gridPos, [-1, 1], [-1, 0, 1]);

var gm	= 4;
var x1, x2, y1, y2;
var tc	= c_white;
var ta	= 0.8;
var i	= 0; repeat(array_length(distance))
{
	x1 = distance[i].x;
	x2 = distance[i].x + 1;
	y1 = distance[i].y;
	y2 = distance[i].y + 1;
	var gr = distance[i];
	
	
	//var j = 0; repeat(ds_list_size(collisions))
	//{
	//	if (instance_exists(collisions[| j]))
	//	{
	//		if (collisions[| j].gridPos.x == x1) && (collisions[| j].gridPos.y == y1)
	//		{
	//			tc = C_CRIMSON;
	//			ta	= 1;
	//			break;
	//		}
	//		else 
	//		{
	//			tc = c_white;
	//			ta	= 0.8;
	//		}
	//	}
	//	j++;
	//}
	if (gridMeeting(gr.x, gr.y, objBlock))
	{
		tc = C_CRIMSON;
		ta	= 1;
	}
	else
	{
		tc = c_white;
		ta = 0.8;
	}	
	gr.blend(merge_color(gr.color, tc, 0.1), approach(gr.alpha, ta, 0.1));
	CleanRectangle(x1 * GRID_W + gm, y1 * GRID_H + gm, x2 * GRID_W - gm, y2 * GRID_H - gm).Blend(gr.color, gr.alpha).Border(2, c_white, 0.8).Rounding(4).Draw();
	i++;
}



