#region Create -----------------------------------------------------------------
//animation
animation_init();
//speed variables
xSpeed		= 0;
ySpeed		= 0;
gSpeed		= 0.06;
facing		= 1;
moveDir 	= new Dir();
lastPos 	= new Vector2();
moveTween	= new TweenV2(tweenType.QUARTEASEIN);
moveTimer	= new Timer();
moveDurMax	= 15;
moveDurMin	= 3;
moveDur		= moveDurMax;

//accel, decel and max speed
aSpeed		= 0.2;
dSpeed		= 0.5;
hMaxSpeed	= 2.5;
vMaxSpeed	= 2.5;
clampSpeed	= function(_horizontal = hMaxSpeed, _vertical = vMaxSpeed)
{
	ySpeed = clamp(ySpeed, -_vertical, _vertical);
	xSpeed = clamp(xSpeed, -_horizontal, _horizontal);
}

groundAccel 	= 0.1;
groundDecel 	= 0.075;
airAccel		= 0.1;
airDecel		= 0.075;
crouchDecel 	= 0.075;


area = [
	[0, 1], [0, 2], [0, -1],
	[1, 0], [2, 0], 
	[-1, 0]

];
distance	= [];
collisions	= ds_list_create();

//control point variables
onGround	= false;
onWall		= false;
onCeiling	= false;
isTouching	= false;

gridPos = new Vector2(x div GRID_W, y div GRID_H);
aGridPos = new Vector2(gridPos.x * GRID_W, gridPos.y * GRID_H);

#region Functions --------------------------------------------------------------
checkCollisions = function()
{
	onGround	= place_meeting(x, y + 1, objBlock);
	onWall		= place_meeting(x + facing, y, objBlock);
	onCeiling	= place_meeting(x, y - 1, objBlock);
	isTouching	= onGround || onWall || onCeiling;
}	

snapPosition	= function()
{
	var _tlx	= x - sprite_xoffset;
	var _tly	= y - sprite_yoffset;
	var _xspc	= _tlx mod GRID_W;
	var _yspc	= _tly mod GRID_H;
	if (_xspc != 0 || _yspc != 0)
	{
		x = _xspc < GRID_W / 2 ? x - _xspc : x + _xspc;
		y = _yspc < GRID_H / 2 ? y - _yspc : y + _yspc;
	}
}

findGridPos 	= function()
{
	gridPos.x = x div GRID_W;
	gridPos.y = y div GRID_H;
}

findAGridPos	= function()
{
	aGridPos.x = gridPos.x * GRID_W;
	aGridPos.y = gridPos.y * GRID_H;
}

drawGrid		= function(_pos, _arr)
{
	static gm = 4;
	var i = 0; repeat(array_length(_arr))
	{
		var xp = _pos.x * GRID_W;
		var yp = _pos.y * GRID_H;
		var xg = _arr[i][0] * GRID_W;
		var yg = _arr[i][1] * GRID_H;
		CleanCapsule(xp + gm + xg, yp + gm + yg, xp - gm + GRID_W + xg, yp - gm + GRID_H + yg, true).Blend(c_white, 0.8).Rounding(4).Draw();
		i++;
	}
}

findDistance	= function(_pos, _area)
{
	var i = 0; repeat(array_length(_area))
	{
		distance[i][0] = _pos.x + _area[i][0];
		distance[i][1] = _pos.y + _area[i][1];
		i++;
	}
}

checkGrid		= function(_target) // free
{
	with (_target)
	{
		var i = 0; repeat(array_length(other.distance))
		{
			if (other.distance[i][0] == self.gridPos.x && other.distance[i][1] == self.gridPos.y) 
			{
				return self;
				break;
			}
			i++;
		}
	}
	return noone;
}

gridList		= function(_dist, _object, _pos = undefined, _arr = undefined, _list = undefined)
{
	static gm		= 1;
	static bl		= noone;
	// ds_list_clear(_list);	created auto list !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if (!ds_exists(_list, ds_type_list))
	{
		_list = ds_list_create();
		show("created list");
	}
	else
	{
		ds_list_clear(_list);
	}
	var i = 0; repeat(array_length(_dist))
	{
		var x1 = _dist[i][0];
		var x2 = _dist[i][0] + 1;
		var y1 = _dist[i][1];
		var y2 = _dist[i][1] + 1;
		var safe = true;
		bl		= collision_line(x1 * GRID_W + gm, y1 * GRID_H + gm, x2 * GRID_W - gm, y2 * GRID_H - gm, _object, false, true);
		var j = 0; repeat(ds_list_size(_list))
		{
			if (ds_list_find_value(_list, j) == bl)
			{
				safe = false;
			}
			j++;
		}
		if (safe)
		{
			collision_line_list(x1 * GRID_W + gm, y1 * GRID_H + gm, x2 * GRID_W - gm, y2 * GRID_H - gm, _object, false, true, _list, false);
		}
		i++;
		
	}
	return _list;
	
}

gridMeeting 	= function(_x, _y, _obj)
{
	if (_x == _obj.gridPos.x && _y == _obj.gridPos.y)
	{
		return true;
	}
	return false;
}

gridPlace		= function(_x, _y, _obj)
{
	with (_obj)
	{
		if (_x == _obj.gridPos.x && _y == _obj.gridPos.y)
		{
			return self;
		}		
	}
	return noone;
}


#endregion //-------------------------------------------------------------------
#region State ------------------------------------------------------------------
state = new SnowState("idle");

state.history_enable();
state.set_history_max_size(15);
state.event_set_default_function("init", function() {
		x = clamp(x, 0, room_width);
		y = clamp(y, 0, room_height);
});

state.add("idle", {
	enter: function() 
	{
		snapPosition();
		findGridPos();
		findDistance(gridPos, area);
		collisions = gridList(distance, objBlock);
	},
	step: function()
	{
		if  (abs(InputManager.horizontalInput) || abs(InputManager.verticalInput))
		{
			moveDur = approach(moveDur, moveDurMin, 2);
		}
		else 
		{
			moveDur = approach(moveDur, moveDurMax, 8);
		}
		
		
		
		#region Switch state
		if (abs(InputManager.horizontalInput))
		{
			moveDir.find(InputManager.horizontalInput, 0);
			lastPos.x = x;
			lastPos.y = y;
			state.change("move")
		}
		else if (abs(InputManager.verticalInput))
		{
			moveDir.find(0, InputManager.verticalInput);
			lastPos.x = x;
			lastPos.y = y;
			state.change("move")
		}
		#endregion
		

	}
});
	
state.add("move", {
	enter: function() 
	{
		moveTween.start(0, 1, moveDur);
		moveTimer.start(moveDur);
	},
	step: function() 
	{
		x = flerp(x, lastPos.x + lengthdir_x(GRID_W, moveDir.angle), moveTween.value);
		y = flerp(y, lastPos.y + lengthdir_y(GRID_H, moveDir.angle), moveTween.value);
		if (moveTween.done || place_meeting(x, y, objBlock))
		{
			moveTween.stop();
			state.change("idle");
		}
	}
});

#endregion //-------------------------------------------------------------------

Camera.following = self;

global.clock.variable_interpolate("x", "iotaX");
global.clock.variable_interpolate("y", "iotaY");

global.clock.add_cycle_method(function() {
	
	
});



