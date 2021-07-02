////////////////////////////////////////////////////////////////////////////////////////////////////////////
//global.signals = {};

//function signal_join(_signal, _id = id)
//{
//	var array = global.signals[$ string(_id)];
//	var safe = true;
//	if (is_array(array))
//	{
//		// Check if array has the signal already
//		var i = 0; repeat(array_length(array))
//		{
//			if (array[i] == _signal)
//			{
//				safe = false;
//				break;
//			}
//			i++;
//		}
//		if (safe) 
//		{
//			array_push(array, _signal);
//		}
//	}
//	else
//	{
//		// If array does not exist, create it
//		global.signals[$ string(_id)] = array_create(1, _signal);
//		array = global.signals[$ string(_id)];
//		//if (!is_undefined(_data)) array_push(array, _data);
//	}
//	if (signal_fnd(_signal, _id))
//	{
//		var data = [];
//		var i = 2; repeat (argument_count - 2) 
//		{
//			array_push(data, argument[i]);
//			i++;
//		}
//		if (array_length(data) > array_length(array) - 1)
//		{
//			var i = 0; repeat (array_length(data))
//			{
//			    array_push(array, data[i]);
//				i++;
//			}	
//		}
//		else
//		{
//			var i = 0; repeat (array_length(data))
//			{
//			    array_set(array, i + 1, data[i]);
//				i++;
//			}			
			
//		}
//	}
//}

//function signal_fnd(_signal, _id = id, _func = function() { })
//{
//	var array = global.signals[$ string(_id)];
//	var data = array_create(0);
//	if (!is_array(array))
//	{
//		return false;
//		exit;
//	}
	
//	if (array[0] == _signal)
//	{
//		var j = 1; repeat (array_length(array) - 1)
//		{
//			array_push(data, array[j]);
//			j++;
//		}
//		if (is_array(data) && array_length(data) > 0) 
//		{
//			script_execute_ext(method_get_index(_func), data);
//		}
//		return true;
//	}
//	return false;
//}

//function signal_leave(_signal, _id = id)
//{
//	var array = global.signals[$ string(_id)];
//	if (!is_array(array)) exit;
//	var i = 0;
//	repeat(array_length(array))
//	{
//		if (array[i] == _signal)
//		{
//			array_delete(global.signals[$ string(_id)], i, 1);
//			break;
//		}
//		i++;
//	}
//	if (array_length(global.signals[$ string(_id)]) <= 0) signal_wipe(_id);
//}

//function signal_wipe(_id = id)
//{
//	if (global.signals[$ _id] != undefined)
//	{
//		variable_struct_remove(global.signals, _id);
//	}
//}

//function signal_equal(_signal, _idone, _idtwo)
//{
//	if (signal_fnd(_signal, _idone) && signal_fnd(_signal, _idtwo))
//	{
//		return true;
//	}
//	return false;
//}

//function signal_clean()
//{
//	delete global.signals;
//}

//signals = [
//	[ "name", ["signal1", ["data"]], ["signal2", ["data2"]] ],
//	[],

//];

//function sgnl(_name, _owner) constructor{
//{
//	name	= _name;
//	owner	= _owner;
//	data	= [];
//}

function Signal(_signal) constructor
{
	signal	= "";
	owner	= noone;
	data	= [];
	if !is_array(global.signals[$ string(signal)]) 
	{
		global.signals[$ string(signal)] = array_create(0);
	}
	array	= global.signals[$ string(signal)];
			
	static Push = function()
	{

		var i = 0; repeat (argument_count) 
		{
			data[i] = argument[i];
			i++;
		}
		
		global.signals[$ string(signal)] = data;
		array	= global.signals[$ string(signal)];
		return self;
	}
	
}

function signal_create(_signal)
{
	var s	 = new Signal(_signal);
	s.signal = _signal;
	s.owner  = self;
	return s;
}

function signal_find(_signal, _owner, _func = function() {})
{
	var strSignal = {};
	var arrSignal = [];
	if (instance_exists(_owner)) 
	{
		strSignal = _owner[$ _signal];
	}
	if (strSignal =! {}) arrSignal = strSignal.array;
	script_execute_ext(method_get_index(_func), arrSignal);	
}



