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

var i = 0; repeat(array_length(_arr))
{
	var xp = _pos.x * GRID_W;
	var yp = _pos.y * GRID_H;
	var xg = _arr[i][0] * GRID_W;
	var yg = _arr[i][1] * GRID_H;
	x1		= min(xg + xp);
	x2		= max(xg + xp);
	y1		= min(yg);
	y2		= max(yg);
	CleanCapsule(xp + gm + xg, yp + gm + yg, xp - gm + GRID_W + xg, yp - gm + GRID_H + yg, true).Blend(c_white, 0.8).Rounding(4).Draw();
	//draw_line(xp + gm + xg, yp + gm + yg, xp - gm + GRID_W + xg, yp - gm + GRID_H + yg);

	i++;
}
x1 = _pos.x;
x2 = _pos.x;
var i = 0; repeat(array_length(distance))
{
	x1 = min(distance[i][0], x1);
	x2 = max(distance[i][0], x2);
}
draw_text(10, 20, x1);
draw_text(10, 30, x2);
draw_line(x1 * GRID_W, yp, x2 * GRID_W, yp);
