/// @description quick and dynamic guibar setup
function GuiBar(_rate = 1) constructor
{ // Makes a bar
	smtRate = _rate;
	static update = function(rate = 1, lrp = true, lrpRate = 0.1)
	{
		if (is_real(rate)) smtRate = lrp ? flerp(smtRate, rate, lrpRate) : rate;
		return self;
	}
	static draw = function(x1, y1, width, height, type = "vertical", color = c_white, alpha = 1, rounded = false, bottomline = false)
	{
		draw_set_alpha(alpha);
		draw_set_color(color);
		if (type == "vertical")
		{ // 0 = vertical
			if (rounded)
			{
				draw_roundrect(x1, y1, x1 + width, y1 + height * smtRate + (bottomline ? sign(height) : 0), false);
			}
			else
			{
				draw_rectangle(x1, y1, x1 + width, y1 + height * smtRate + (bottomline ? sign(height) : 0), false);
			}
		}
		else if (type == "horizontal")
		{ // 1 = horizontal
			if (rounded)
			{
				draw_roundrect(x1, y1, x1 + width * smtRate + (bottomline ? sign(width) : 0), y1 + height, false);
			}
			else
			{
				draw_rectangle(x1, y1, x1 + width * smtRate + (bottomline ? sign(width) : 0), y1 + height, false);
			}
		}
		draw_set_alpha(1);
		draw_set_color(c_white);
		return self;
	}
	
}

function DrawBar(_x1, _y1, _width, _height)
{
	return new __GuiBar(_x1, _y1, _width, _height);	
}

/// @description quick and dynamic guibar setup
function __GuiBar(_x1, _y1, _width, _height) constructor
{ // Makes a bar
	x1 = _x1;
	y1 = _y1;
	width = _width;
	height = _height;
	smtRate = 1;
	color = c_white;
	alpha = 1;
	type = "horizontal";
	rounded = false;
	bottomline = true;
	
	
	static Update = function(_rate = 1, _lrp = true, _lrpRate = 0.1)
	{
		smtRate = _lrp ? flerp(smtRate, _rate, _lrpRate) : _rate;
		return self;
	}
	
	static Blend = function(_color = c_white, _alpha = 1)
	{
		color = _color;
		alpha = _alpha;
		return self;
	}
	
	static Type = function(_type = "horizontal")
	{
		type = _type;
		return self;
	}
	
	static Shape = function(_rounded = false, _bottomline = true)
	{
		rounded = _rounded;
		bottomline = _bottomline;
		return self;
	}
	static Draw = function()
	{
		draw_set_alpha(alpha);
		draw_set_color(color);
		if (type == "vertical")
		{ // 0 = vertical
			if (rounded)
			{
				draw_roundrect(x1, y1, x1 + width, y1 + height * smtRate + (bottomline ? sign(height) : 0), false);
			}
			else
			{
				draw_rectangle(x1, y1, x1 + width, y1 + height * smtRate + (bottomline ? sign(height) : 0), false);
			}
		}
		else if (type == "horizontal")
		{ // 1 = horizontal
			if (rounded)
			{
				draw_roundrect(x1, y1, x1 + width * smtRate + (bottomline ? sign(width) : 0), y1 + height, false);
			}
			else
			{
				draw_rectangle(x1, y1, x1 + width * smtRate + (bottomline ? sign(width) : 0), y1 + height, false);
			}
		}
		draw_set_alpha(1);
		draw_set_color(c_white);
		return self;
	}
}

function Dir() constructor
{ // Finds x and y direction(like 0, 1 or -1) and angle
	angle = undefined;
	x = 0;
	y = 0;
	static find = function(_hinput, _vinput)
	{
		angle = point_direction(0, 0, _hinput, _vinput);
		x = _hinput;
		y = _vinput;
		return self;
	}
}

function Timer() constructor
{ // For basic timer
	time = 0;
	done = false;
	active = false;
	sTime = undefined;
	duration = 0;
	static start = function(_duration = infinity, _loop = false)
	{
		duration = _duration;
		if (done == true) done = false;
		if (active == false) active = true;
		return self;
	}

	static startRt = function(_duration, _loop = false)
	{ // Duration in seconds
		var sec = current_time * 0.001;
		if (sTime == undefined) sTime = sec;
		if (!_loop)
		{
			if (sec >= sTime + _duration)
			{
				done = true;
				active = false;
				exit;
			}
			else
			{
				done = false;
				active = true;
			}
		}
		else
		{
			active = true;
			if (sec >= sTime + _duration)
			{
				done = true;
				sTime = sec;
			}
			else
			{
				done = false;
			}
		}
		return self;
	}
	static onTimeout = function(_func)
	{
		if (done)
		{
			_func();
		}
		return self;
	};
	static reset = function()
	{
		time = 0;
		sTime = undefined;
		done = false;
		active = true;
		return self;

	};
	static stop = function()
	{
		time = 0;
		sTime = undefined;
		active = false;
		done = false;
		return self;
	};
	
	global.clock.add_cycle_method(function()
	{
		if (active)
		{
			time++;
			if (time >= duration)
			{
				done = true;
			}
		}
		
	});
}

function Vector2(_x = undefined, _y = undefined) constructor
{
	x = _x;
	y = _y;
	return self;
	
}

function Vector3(_x = undefined, _y = undefined, _z = undefined) constructor
{
	x = _x;
	y = _y;
	z = _z;
	return self;	
}











