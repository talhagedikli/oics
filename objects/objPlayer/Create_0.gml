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
	[0, 1],
	[0, 2],
	[0, -1],
	[1, 0], 
	[-1, 0]
];



dirfind 		= function(_area)
{
	var r, u, l, d;
	r = array_create(0);
	u = array_create(0);
	l = array_create(0);
	d = array_create(0);
	var resize = array_create(4, 0);
	var i = 0; repeat(array_length(_area))
	{
		var _x = _area[i][0];
		var _y = _area[i][1];
		if (_x >= 0 && _y == 0)
		{
			resize[0]++;
			array_resize(r, resize[0]);
			r[resize[0] - 1] = _x;
		}
		else if (_x = 0 && _y <= 0)
		{
			resize[1]++;
			array_resize(u, resize[1]);
			u[resize[1] - 1] = _y;
		}	
		else if (_x <= 0 && _y == 0)
		{
			resize[2]++;
			array_resize(l, resize[2]);
			l[resize[2] - 1] = _x;
		}
		else if (_x == 0 && _y >= 0)
		{
			resize[3]++;
			array_resize(d, resize[3]);
			d[resize[3] - 1] = _y;
		}
		i++;
	}
	return [r, u, l, d];
}

//show(dirfind(area));

distance	= array_create(array_length(area));
collisions	= ds_list_create();

//control point variables
onGround	= false;
onWall		= false;
onCeiling	= false;
isTouching	= false;

gridPos 	= new Vector2(x div GRID_W, y div GRID_H);

#region Functions --------------------------------------------------------------
// Distance with structs
findDistance	   = function(_pos, _area)
{
    var i = 0; repeat(array_length(_area))
    {
		if (array_length(distance) != array_length(_area))
		{
			array_resize(distance, array_length(_area));
		}
        if (!is_struct(distance[i]))
        {
            distance[i] = new Grid(_pos.x + _area[i][0], _pos.y + _area[i][1]);
        }
        else
        {
            distance[i].set(_pos.x + _area[i][0], _pos.y + _area[i][1]);
        }
        i++;
    }
}
findDistance(gridPos, area);
// Distance with structs2
area2 = [
	[1, 2],	// Right (y = 0)
	[-1],	// Up (x = 0)
	[-1],	// Left (y = 0)
	[1]	// Down (x = 0)
];
distance2 = [];
findDistance2	   = function(_pos, _area)
{
	var index	= 0;
	var len 	= 1;
    var i = 0; repeat(array_length(_area))
    {
		var j = 0; repeat(array_length(_area[i]))
		{
			array_resize(distance2, len);
			var _x = (i mod 2 == 0 ? _area[i][j] : 0);
			var _y = (i mod 2 == 0 ? 0 : _area[i][j]);
	        if (!is_struct(distance2[index]))
	        {
	            distance2[index] = new Grid(_pos.x + _x, _pos.y + _y);
	        }
	        else
	        {
				distance2[index].set(_pos.x + _x, _pos.y + _y);
			}
			
			j++;
			len++;
			index++;
		}
        i++;
    }
}


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

gridList		= function(_dist, _object, _pos = undefined, _arr = undefined)
{
	static gm		= 1;
	static bl		= noone;
	static _list	= ds_list_create();
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
		var x1 = _dist[i].x;
		var x2 = _dist[i].x + 1;
		var y1 = _dist[i].y;
		var y2 = _dist[i].y + 1;
		var gr = _dist[i];
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
	if (instance_exists(_obj))
	{	
		return position_meeting(_x * GRID_W, _y * GRID_H, _obj);
	}
		return false;
}

gridPlace		= function(_x, _y, _obj)
{
	if instance_exists(_obj)
	{
		return instance_position(_x * GRID_W, _y * GRID_H, _obj);
	}
	return noone;
}

distanceMeeting	= function(_dist = distance, _obj)
{
	var i = 0; repeat(array_length(_dist))
	{
		var bl = gridPlace(_dist[i].x, _dist[i].y, _obj);
		if(bl != noone)
		{
			return true;
		}
		i++;
	}
	return false;
}

distancePlace	= function(_dist = distance, _obj)
{
	var i = 0; repeat(array_length(_dist))
	{
		var bl = gridPlace(_dist[i].x, _dist[i].y, _obj);
		if(bl != noone)
		{
			return bl;
		}
		i++;
	}
	return noone;
}
		

structMeeting	= function(_x, _y, _obj)
{
	if (is_struct(_obj))
	{
		var i = 0; repeat (_obj.xScale)
		{
			var j = 0; repeat (_obj.yScale)
			{
				if (_x == _obj.x + i && _y == _obj.y + j)
				{
					return true;
				}
				j++;
			}
			i++;
		}
	}
	else if (instance_exists(_obj))
	{
		return position_meeting(_x * GRID_W, _y * GRID_H, _obj);
	}
	return false;
}

structPlace		= function(_x, _y, _obj)
{
	if (is_struct(_obj))
	{
		var i = 0; repeat (_obj.xScale)
		{
			var j = 0; repeat (_obj.yScale)
			{
				if (_x == _obj.x + i && _y == _obj.y + j)
				{
					return _obj;
				}
				j++;
			}
			i++;
		}
	}
	else if (instance_exists(_obj))
	{
		return instance_position(_x * GRID_W, _y * GRID_H, _obj);
	}
	return noone;
}

#endregion //-------------------------------------------------------------------
#endregion //-------------------------------------------------------------------
#region State ------------------------------------------------------------------
state = new SnowState("idle");

state.history_enable();
state.set_history_max_size(15);
state.event_set_default_function("init", function() 
{
		x = clamp(x, 0, room_width);
		y = clamp(y, 0, room_height);
});

state.add("idle", {
	enter: function() 
	{
		snapPosition();
		gridPos.set(x div GRID_W, y div GRID_H);
		findDistance(gridPos, area);
		findDistance2(gridPos, area2);
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
		
		if (keyboard_check_pressed(ord("E")))
		{
			var bl = distancePlace(distance, objBlock);
			if instance_exists(bl) bl.fadeOut = true;
		}
		
		#region Switch state
		if (abs(InputManager.horizontalInput) && !gridMeeting(gridPos.x + InputManager.horizontalInput, gridPos.y, objSolidParent))
		{
			moveDir.find(InputManager.horizontalInput, 0);
			lastPos.x = x;
			lastPos.y = y;
			state.change("move")
		}
		else if (abs(InputManager.verticalInput) && !gridMeeting(gridPos.x, gridPos.y + InputManager.verticalInput, objSolidParent))
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
		if (moveTween.done)
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



