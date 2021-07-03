/// @description  approach(start, end, shift);
/// @param start
/// @param  end
/// @param  shift
function approach(argument0, argument1, argument2)
{
	if (argument0 < argument1)
	{
		return min(argument0 + argument2, argument1);
	}
	else
	{
		return max(argument0 - argument2, argument1);
	}
}

function normalize_value(value, min, max)
{
	var normalized = (value - min) / (max - min);
	normalized = clamp(normalized, 0, 1);
	return normalized;
}


function wave(_from, _to, _duration, offset)
{
	//Wave(from, to, duration, offset)
	// Returns a value that will wave back and forth between [from-to] over [duration] seconds
	// Examples
	//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
	//      x = Wave(-10,10,0.25,0)         -> move left and right quickly
	// Or here is a fun one! Make an object be all squishy!! ^u^
	//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
	//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)
	var _a4 = (_to - _from) * 0.5;
	return _from + _a4 + sin((((current_time * 0.001) + _duration * offset) / _duration) * (pi * 2)) * _a4;
}
/// @description Puts sin function inside of abs function
function asin(time = current_time)
{
	return abs(dsin(time));
}

/// @description Puts cos function inside of abs function
function acos(time = current_time)
{
	return abs(dcos(time));
}

///Map(val, min1, max1, min2, max2)   
function remap(value, min1, max1, min2, max2)
{
	/*      
	value = 110;      
	m = Map(value, 0, 100, -20, -10);      
	// m = -9      
	*/
	return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
}

/// @description
/// @description Chance(percent)
/// @param percent
function chance(_percent)
{
	// Returns true or false depending on RNG
	// ex: 
	//		Chance(0.7);	-> Returns true 70% of the time
	return _percent > random(1);
}

// Finite lerp function
function flerp(val1, val2, amount, epsilon = EPSILON)
{
	return abs(val1 - val2) > epsilon ? lerp(val1, val2, amount) : val2;
}






