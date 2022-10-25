/// @description check 1 pixel collisions
//
function check_collisions_classic() {
	//horizontal collision
	if (tile_meeting(x+xSpeed, y, "Matrix"))
	{
		while (!tile_meeting(x+sign(xSpeed), y, "Matrix"))
		{
			x = x + sign(xSpeed);
		}
		xSpeed = 0;
	}
	//applying xSpeed
	x = x + xSpeed;

	//vertical collision
	if (tile_meeting(x, y+ySpeed, "Matrix"))
	{
		while (!tile_meeting(x, y+sign(ySpeed), "Matrix"))
		{
			y = y + sign(ySpeed);
		}
		ySpeed = 0;
	}
	//applying ySpeed
	y = y + ySpeed;

}


function check_collisions_pixel_perfect(_object = objBlock) { /// @description the pixel perfect collisions

	//I think this is better calculation for single mask
	var sprite_bbox_top		= sprite_get_bbox_top(sprite_index)		- sprite_get_yoffset(sprite_index);
	var sprite_bbox_bottom	= sprite_get_bbox_bottom(sprite_index)	- sprite_get_yoffset(sprite_index);
	var sprite_bbox_right	= sprite_get_bbox_right(sprite_index)	- sprite_get_xoffset(sprite_index);
	var sprite_bbox_left	= sprite_get_bbox_left(sprite_index)	- sprite_get_xoffset(sprite_index);

	//Applying horizontal speed if there is no collision with block
	x += xSpeed;
	//Horizontal collisions
	if place_meeting(x + sign(xSpeed), y, _object) {
		var wall = instance_place(x + sign(xSpeed), y, _object);
		if (xSpeed > 0)
		{ //right
			x = (wall.bbox_left - 1) - sprite_bbox_right;
		} 
		else if (xSpeed < 0)
		{ //left
			x = (wall.bbox_right + 1) - sprite_bbox_left;
		}
		xSpeed = 0;
	}

	//Applying vertical speed if there is no collision with block
	y += ySpeed;
	//Vertical collisions
	if place_meeting(x, y + sign(ySpeed), _object) {
		var wall = instance_place(x, y + sign(ySpeed), _object);
		if (ySpeed > 0)
		{ //down
			y = (wall.bbox_top - 1) - sprite_bbox_bottom;
		}
		else if (ySpeed < 0)
		{ //up
			y = (wall.bbox_bottom + 1) - sprite_bbox_top;
		}
		ySpeed = 0;
	}


}

function check_collisions_tile_perfect() { /// @description the pixel perfect collisions

	//I think this is better calculation for single mask
	var sprite_bbox_top		= sprite_get_bbox_top(sprite_index)		- sprite_get_yoffset(sprite_index);
	var sprite_bbox_bottom	= sprite_get_bbox_bottom(sprite_index)	- sprite_get_yoffset(sprite_index);
	var sprite_bbox_right	= sprite_get_bbox_right(sprite_index)	- sprite_get_xoffset(sprite_index);
	var sprite_bbox_left	= sprite_get_bbox_left(sprite_index)	- sprite_get_xoffset(sprite_index);
	
	var tile				= layer_tilemap_get_id("Matrix");
	
	//Applying horizontal speed if there is no collision with block
	x += xSpeed;
	//Horizontal collisions
	if tile_meeting(x + sign(xSpeed), y, "Matrix") {
		var wall = tilemap_get_at_pixel(tile, x + sign(xSpeed), y);
		if (xSpeed > 0)
		{ //right
			x = (wall.bbox_left - 1) - sprite_bbox_right;
		} 
		else if (xSpeed < 0)
		{ //left
			x = (wall.bbox_right + 1) - sprite_bbox_left;
		}
		xSpeed = 0;
	}

	//Applying vertical speed if there is no collision with block
	y += ySpeed;
	//Vertical collisions
	if tile_meeting(x, y + sign(ySpeed), "Matrix") {
		var wall = tilemap_get_at_pixel(tile, x, y + sign(ySpeed));
		if (ySpeed > 0)
		{ //down
			y = (wall.bbox_top - 1) - sprite_bbox_bottom;
		}
		else if (ySpeed < 0)
		{ //up
			y = (wall.bbox_bottom + 1) - sprite_bbox_top;
		}
		ySpeed = 0;
	}


}

function tile_collisions(_tile)
{
	if tile_meeting(x + xSpeed, y, _tile)
	{
		while !tile_meeting(x + sign(xSpeed), y, _tile)
		{
			x += sign(xSpeed); 	
		}
		xSpeed = 0;
	}
	x += xSpeed;
	
	if tile_meeting(x, y + ySpeed, _tile)
	{
		while !tile_meeting(x, y + sign(xSpeed), _tile)
		{
			y += sign(ySpeed); 	
		}
		ySpeed = 0;
	}
	y += ySpeed;
	
}

///@description tile_meeting(x,y,layer)
///@param x
///@param y
///@param layer
function tile_meeting(argument0, argument1, argument2) {
	var _layer = argument2,
	    _tm = layer_tilemap_get_id(_layer);
 
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (argument0 - x), y),
	    _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (argument1 - y)),
	    _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (argument0 - x), y),
	    _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (argument1 - y));
 
	for(var _x = _x1; _x <= _x2; _x++){
	  for(var _y = _y1; _y <= _y2; _y++){
	    if(tile_get_index(tilemap_get(_tm, _x, _y))){
	      return true;
	    }
	  }
	}
 
	return false;


}

///@description tile_meeting_precise(x,y,layer)
///@param x
///@param y
///@param layer
function tile_meeting_precise(argument0, argument1, argument2) {
	var _layer = argument2,
	    _tm = layer_tilemap_get_id(_layer),
	    _checker = obj_precise_tile_checker;
	if(!instance_exists(_checker)) instance_create_depth(0,0,0,_checker);  

 
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (argument0 - x), y),
	    _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (argument1 - y)),
	    _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (argument0 - x), y),
	    _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (argument1 - y));
 
	for(var _x = _x1; _x <= _x2; _x++){
	  for(var _y = _y1; _y <= _y2; _y++){
	var _tile = tile_get_index(tilemap_get(_tm, _x, _y));
	if(_tile){
	  if(_tile == 1) return true;
     
	  _checker.x = _x * tilemap_get_tile_width(_tm);
	  _checker.y = _y * tilemap_get_tile_height(_tm);
	  _checker.image_index = _tile;
     
	  if(place_meeting(argument0,argument1,_checker))
	    return true;
	}
	  }
	}
 
	return false;


}
