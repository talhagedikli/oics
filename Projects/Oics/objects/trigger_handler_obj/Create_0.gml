function_map = ds_map_create();
fnc_stack = ds_stack_create(); // In case of nested statements
detached_list = ds_list_create();

setting_count = 0;  // Used for better error throwing
fnc = undefined;

function process_events(){
		///	@desc Execute Detached
	for (var i = 0; i < ds_list_size(detached_list); ++i){
		
		var _fnc = detached_list[| i];
		
		// Make sure we are in the correct event:
		if (event_type != ev_draw and _fnc.evt == ev_draw)
			continue;
		if (event_type == ev_draw and _fnc.evt != ev_draw)
			continue;
		if (event_type == ev_step and _fnc.evt == ev_step and event_number != _fnc.evn)
			continue;
		if (event_type == ev_draw and _fnc.evt == ev_draw and event_number != _fnc.evn){
			if (_fnc.evn == 0) // GM bug work-around for game-start triggers in draw. Just default to normal draw event
				_fnc.evn = event_number;
			else
				continue;
		}

		// Units:	0 = hours
		//			1 = minutes
		//			2 = seconds
		//			3 = milliseconds
		//			4 = frames
		with (_fnc.inst_id){
			if (_fnc.unit < 4){
				var multipliers = [
					360000,
					60000,
					1000,
					1
				];
				var _executewhen = _fnc.start_time + _fnc.value * multipliers[_fnc.unit];
				if (_executewhen <= current_time){ // Time to execute!
			
					_fnc.meth();
					if (_fnc.is_repeat)
						_fnc.start_time += _fnc.value * multipliers[_fnc.unit]; // Reset for more
					else{
						ds_list_delete(other.detached_list, i);
						--i;
						if (not _fnc.kill_once){
							var _methodstr = string(_fnc.inst_id) + ":" + string(method_get_index(_fnc.meth));
							other.function_map[? _methodstr] = undefined;
						}
					}
				}
			}
			else if (_fnc.unit == 4){ // Frame count
		
				_fnc.value -= 1;
				if (_fnc.value <= 0){
					_fnc.meth();
					if (_fnc.is_repeat)
						_fnc.value = _fnc.start_time;
					else{
						ds_list_delete(other.detached_list, i);
						--i;
						if (not _fnc.kill_once){
							var _methodstr = string(_fnc.inst_id) + ":" + string(method_get_index(_fnc.meth));
							other.function_map[? _methodstr] = undefined;
						}
					}
				}
			}
		}
		
		if (not instance_exists(_fnc.inst_id)){
			ds_list_delete(detached_list, i);
			--i;
		}	
	}
}