///	=== QUICK SYNTAX REFERENCE
//	trigger <repetition> <time> <unit>{
//		/* Code */
//	} <execution method>;
//
//	trigger once <repetition> <time> <unit>{
//		/* Code */
//	} <execution method>;

#macro trigger __trigger_begin(				
#macro hours ,0).fnc=function()			
#macro hour ,0).fnc=function()		
#macro minutes ,1).fnc=function()	
#macro minute ,1).fnc=function()
#macro seconds ,2).fnc=function()
#macro second ,2).fnc=function()
#macro milliseconds ,3).fnc=function()
#macro millisecond ,3).fnc=function()
#macro frames ,4).fnc=function()
#macro frame ,4).fnc=function()
#macro attached __trigger_attached();
#macro detached __trigger_detached();
#macro once -1,
#macro in 0,
#macro every 1,
#macro __TRIGGER_DEPTH_LIMIT 24	// How deep can nests go until an error is thrown

function __trigger_begin(){
	if (not instance_exists(trigger_handler_obj))
		instance_create_depth(0, 0, 999, trigger_handler_obj);

	with (trigger_handler_obj){
		if (not is_undefined(fnc)) // If already setting a function me are nesting, store it:
			ds_stack_push(fnc_stack, {fnc : fnc, is_repeat : is_repeat, value : value, unit : unit, start_time : start_time, kill_once : kill_once});
	}

	with (trigger_handler_obj){
		if (argument_count == 2){
			is_repeat = false
			value = argument[0];
			unit = argument[1];
			start_time = (argument[1] < 4) ? current_time : value;
			kill_once = false;
			
		}
		else if (argument_count == 3){
			is_repeat = argument[0];
			value = argument[1];
			unit = argument[2];
			start_time = (argument[2] < 4) ? current_time : value;
			kill_once = false;
		}
		else if (argument_count == 4){
			kill_once = (argument[0] < 0 and not argument[1]);
			is_repeat = argument[1];
			value = argument[2];
			unit = argument[3];
			start_time = (argument[3] < 4) ? current_time : value;
		}
	}
	
	// Increment our tracker; allows potential syntax issue catching
	trigger_handler_obj.setting_count += 1;
	
	if (trigger_handler_obj.setting_count > __TRIGGER_DEPTH_LIMIT){
		show_error("Reached WAIT depth limit of [" + string(__TRIGGER_DEPTH_LIMIT) + "]!\nAre you missing an 'attached' or 'detached' after calling 'wait'?", true);
	}

	return trigger_handler_obj;
}

function __trigger_attached(){
	if (not instance_exists(trigger_handler_obj))
		show_error( "Cannot call 'attached' without a 'wait'!", true);
	if (trigger_handler_obj.setting_count <= 0)
		show_error( "Cannot call 'attached' without a 'wait'!", true);
		
	var _method = method(id, trigger_handler_obj.fnc);
	var _methodstr = string(id) + ":" + string(method_get_index(_method));
	var _data = trigger_handler_obj.function_map[? _methodstr];

	if (is_undefined(_data)){ // New function, add it
		var _did_trigger = false;
		if (trigger_handler_obj.value <= 0){ // If NO wait, just execute
			_did_trigger = true;
			_method();
		}

		if (not _did_trigger or not trigger_handler_obj.kill_once or trigger_handler_obj.is_repeat){
			trigger_handler_obj.function_map[? _methodstr] = {
				is_repeat : trigger_handler_obj.is_repeat,
				start_time : trigger_handler_obj.start_time,
				value : trigger_handler_obj.value,
				unit : (_did_trigger and trigger_handler_obj.kill_once) ? -1 : trigger_handler_obj.unit,
				meth : _method,
				kill_once : trigger_handler_obj.kill_once
			}
		}
	}
	else{ // Old function, check it
		// Units:	0 = hours
		//			1 = minutes
		//			2 = seconds
		//			3 = milliseconds
		//			4 = frames
		if (_data.unit < 4 and _data.unit >= 0){
			var multipliers = [
				360000,
				60000,
				1000,
				1
			];
			var _executewhen = _data.start_time + _data.value * multipliers[_data.unit];
			if (_executewhen <= current_time){ // Time to execute!
				_data.meth();
				if (_data.is_repeat)
					_data.start_time += _data.value * multipliers[_data.unit]; // Reset for more
				else{
					if (_data.kill_once)
						_data.unit = -1; // Disable, never execute again
					else // Disable, but allow for a reset
						trigger_handler_obj.function_map[? _methodstr] = undefined;
				}
			}
		}
		else if (_data.unit == 4){ // Frame count
			_data.value -= 1;
			if (_data.value <= 0){
				_data.meth();
					
				if (_data.is_repeat)
					_data.value = _data.start_time;
				else{
					if (_data.kill_once)
						_data.unit = -1; // Disable, never execute again
					else // Disable, but allow for a reset
						trigger_handler_obj.function_map[? _methodstr] = undefined;
				}
			}
		}
	}
			
		// If in a nest, set values back for last statement:
	if (not ds_stack_empty(trigger_handler_obj.fnc_stack)){
		var data = ds_stack_pop(trigger_handler_obj.fnc_stack);
		trigger_handler_obj.fnc = data.fnc;
		trigger_handler_obj.is_repeat = data.is_repeat;
		trigger_handler_obj.value = data.value;
		trigger_handler_obj.unit = data.unit;
		trigger_handler_obj.start_time = data.start_time;
		trigger_handler_obj.kill_once = data.kill_once;
	}
	else
		trigger_handler_obj.fnc = undefined;
				
	trigger_handler_obj.setting_count -= 1;
}

function __trigger_detached(){
	if (not instance_exists(trigger_handler_obj))
		show_error( "Cannot call 'detached' without a 'wait'!", true);
		
	if (trigger_handler_obj.setting_count <= 0)
		show_error( "Cannot call 'detached' without a 'wait'!", true);
		
	var _method = method(id, trigger_handler_obj.fnc);
	var _methodstr = string(id) + ":" + string(method_get_index(_method));
	var _data = trigger_handler_obj.function_map[? _methodstr];	

	if (is_undefined(_data)){ // New function, add it
		var _did_trigger = false;
		if (trigger_handler_obj.value <= 0){ // If NO wait, just execute
			_did_trigger = true;
			_method();
		}

		if (not _did_trigger or not trigger_handler_obj.kill_once or trigger_handler_obj.is_repeat){
			trigger_handler_obj.function_map[? _methodstr] = {};	// Fill spot so we know we have it
			ds_list_add(trigger_handler_obj.detached_list, {
				inst_id : id,
				is_repeat : trigger_handler_obj.is_repeat,
				start_time : trigger_handler_obj.start_time,
				value : trigger_handler_obj.value,
				unit : trigger_handler_obj.unit,
				meth : _method,
				evt : event_type,
				evn : event_number,
				kill_once : trigger_handler_obj.kill_once
			});
		}
	}
			
		// If in a nest, set values back for last statement:
	if (not ds_stack_empty(trigger_handler_obj.fnc_stack)){
		var data = ds_stack_pop(trigger_handler_obj.fnc_stack);
		trigger_handler_obj.fnc = data.fnc;
		trigger_handler_obj.is_repeat = data.is_repeat;
		trigger_handler_obj.value = data.value;
		trigger_handler_obj.unit = data.unit;
		trigger_handler_obj.start_time = data.start_time;
		trigger_handler_obj.kill_once = data.kill_once;
	}
	else
		trigger_handler_obj.fnc = undefined;
				
	trigger_handler_obj.setting_count -= 1;
}