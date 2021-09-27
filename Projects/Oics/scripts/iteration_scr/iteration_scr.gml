///	=== QUICK SYNTAX:
//		iterate <structure> <direction>{
//			/* Code */
//		} <structure type>;

#macro iterate __iterate_begin(
#macro forward ,1).fnc=function(it)
#macro backward ,-1).fnc=function(it)
#macro itt_array __iterate(0);
#macro itt_ds_list __iterate(1);
#macro itt_ds_map __iterate(2);
#macro itt_ds_queue __iterate(3);
#macro itt_ds_stack __iterate(4);

function __iterate_begin(_value, _dir){
	if (not instance_exists(iterator_handler_obj))
		instance_create_depth(0, 0, 998, iterator_handler_obj);
		
	// Store previous in case of nested loop:
	if (not is_undefined(iterator_handler_obj.fnc)){
		ds_stack_push(iterator_handler_obj.function_stack, {
			value : iterator_handler_obj.value,
			fnc : iterator_handler_obj.fnc,
			dir : iterator_handler_obj.dir
		});
	}
		
	iterator_handler_obj.value = _value;
	iterator_handler_obj.dir = _dir;
	return iterator_handler_obj;
}

function __iterate(_type){
	if (not instance_exists(iterator_handler_obj))
		show_error("Invalid iterator loop syntax!", true);
	
	if (is_undefined(iterator_handler_obj.fnc))
		show_error("Invalid iterator loop syntax!", true);
		
	var _fnc = iterator_handler_obj.fnc;
	var _value = iterator_handler_obj.value;
	var _dir = iterator_handler_obj.dir;
	
	var _method = method(id, _fnc);
	
	var r = ref();
	if (_type == 0){
		if (not is_array(_value))
			show_error("Iterative loop expected type [array]!", true);
			
		for (var i = 0; i < array_length(_value); ++i){
			var idx = (_dir > 0) ? i : (array_length(_value) - i - 1);

			r.set(_value[idx]);			// Create iterator
			_method(r.inc());			// Call custom script
			r.dec();					// Dereference extra count
			_value[@ idx] = r.get();	// Store new value and delete
		}
	}
	else if (_type == 1){
		if (not is_real(_value) or not ds_exists(_value, ds_type_list))
			show_error("Iterative loop expected type [ds_list]!", true);
			
		for (var i = 0; i < ds_list_size(_value); ++i){
			var idx = (_dir > 0) ? i : (ds_list_size(_value) - i - 1);

			r.set(_value[| idx]);		// Create iterator
			_method(r.inc());			// Call custom script
			r.dec();					// Dereference extra count
			_value[| idx] = r.get();	// Store new value and delete
		}
	}
	else if (_type == 2){
		if (not is_real(_value) or not ds_exists(_value, ds_type_map))
			show_error("Iterative loop expected type [ds_map]!", true);
		
		var _a = ds_map_keys_to_array(_value);
			
		for (var i = 0; i < array_length(_a); ++i){
			var idx = (_dir > 0) ? i : (array_length(_a) - i - 1);
			
			var v = _value[? _a[idx]];
			r.set({
				key : _a[idx],
				value : v
			})
			
			_method(r.inc());			// Call custom script
			r.dec();					// Dereference extra count
			var s = r.get();
			if (s.key != _a[idx]){
				_value[? _a[idx]] = undefined;	// Clear old map
				_value[? s.key] = s.value;
			}
			else{
				if (s.value != v)
					_value[? s.key] = s.value;
			}
		}
	}
	else if (_type == 3){
		if (not is_real(_value) or not ds_exists(_value, ds_type_queue))
			show_error("Iterative loop expected type [ds_queue]!", true);
			
		var tmp_list = ds_list_create();
	
		while (not ds_queue_empty(_value))
			ds_list_add(tmp_list, ds_queue_dequeue(_value));
		
		for (var i = 0; i < ds_list_size(tmp_list); ++i){
			var idx = (_dir > 0) ? i : (ds_list_size(_value) - i - 1);

			r.set(tmp_list[| idx]);		// Create iterator
			_method(r.inc());			// Call custom script
			r.dec();					// Dereference extra count
			tmp_list[| idx] = r.get();	// Store new value and delete
		}
		
		for (var i = 0; i < ds_list_size(tmp_list); ++i)
			ds_queue_enqueue(_value, tmp_list[| i]);
		
		ds_list_destroy(tmp_list);
	}
	else if (_type == 4){
		if (not is_real(_value) or not ds_exists(_value, ds_type_stack))
			show_error("Iterative loop expected type [ds_stack]!", true);
			
		var tmp_list = ds_list_create();
	
		while (not ds_stack_empty(_value))
			ds_list_add(tmp_list, ds_stack_pop(_value));
		
		for (var i = 0; i < ds_list_size(tmp_list); ++i){
			var idx = (_dir > 0) ? i : (ds_list_size(_value) - i - 1);

			r.set(tmp_list[| idx]);	// Create iterator
			_method(r.inc());			// Call custom script
			r.dec();					// Dereference extra count
			tmp_list[| idx] = r.get();	// Store new value and delete
		}
		
		for (var i = ds_list_size(tmp_list) - 1; i >= 0; --i)
			ds_stack_push(_value, tmp_list[| i]);
		
		ds_list_destroy(tmp_list);
	}
	
	deref(r);

	if (not ds_stack_empty(iterator_handler_obj.function_stack)){
		var _data = ds_stack_pop(iterator_handler_obj.function_stack);
		
		iterator_handler_obj.fnc = _data.fnc;
		iterator_handler_obj.value = _data.value;
		iterator_handler_obj.dir = _data.dir;
	}
	else
		iterator_handler_obj.fnc = undefined;
}