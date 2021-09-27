/// @desc   A simple function that takes an array of arguments and passes them
///         into a function regularly. Supports up to 12 arguments.
/// @param  {script}    function    function to execute
/// @param  {array}     array       array of arguments to pass
/// @returns    {any}   returns whatever the script returns
function callv(_method, _params) {
    if (not is_array(_params))
        throw "Invalid parameter type [1]!";
    
    var _param_count = array_length(_params);
    if (_param_count == 0)
        return _method();
    else if (_param_count == 1)
        return _method(_params[0]);
    else if (_param_count == 2)
        return _method(_params[0], _params[1]);
    else if (_param_count == 3)
        return _method(_params[0], _params[1], _params[2]);
    else if (_param_count == 4)
        return _method(_params[0], _params[1], _params[2], _params[3]);
    else if (_param_count == 5)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4]);
    else if (_param_count == 6)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5]);
    else if (_param_count == 7)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5], _params[6]);
    else if (_param_count == 8)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5], _params[6], _params[7]);
    else if (_param_count == 9)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5], _params[6], _params[7],
                       _params[8]);
    else if (_param_count == 10)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5], _params[6], _params[7],
                       _params[8], _params[9]);
    else if (_param_count == 11)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5], _params[6], _params[7],
                       _params[8], _params[9], _params[10]);
    else if (_param_count == 12)
        return _method(_params[0], _params[1], _params[2], _params[3],
                       _params[4], _params[5], _params[6], _params[7],
                       _params[8], _params[9], _params[10], _params[11]);
        
    throw "Too many arguments for callv [" + string(_param_count - 1) + "]!";
}

/// @desc   Exactly the same as callv only it calls it the beginning of the 
///         following frame and cannot return a value.
///         Execution is performed at the next 'step_begin' event on a layer
///			depth of 1000.
/// @param  {script}    function    function to execute
/// @param  {array}     array       array of arguments to pass
/// @param  {real}      [delay]     if set, waits at least this many seconds
/// @returns    {undefined}
function callv_deferred(_method, _params){
    var _delay = 0;
    if (argument_count > 2)
        _delay = real(argument[2])
    if (not instance_exists(deferred_handler_obj))
        instance_create_depth(0, 0, 1000, deferred_handler_obj)
        
    ds_queue_enqueue(deferred_handler_obj.deferred_requests, [_method, _params, current_time + _delay * 1000]);
    return undefined;
}

/// @desc   Creates a new signaler. Each signaler must have "free()" called
///         before destruction to avoid memory leaks.
///         A Signaler is a structure that can passively trigger scripts on
///         behalf of objects when some special event occurs while allowing for
///         dynamic argument passing upon attachment and execution.
///         
///         Arguments can be specified when attaching a signal and when calling
///         a signal. Any arguments attached at connection will be provided after
///         arguments provided upon call.
///
///         Signals can be slow to set up / destroy, however they are fast at
///         executing. You should aim to only connect things one time if possible.
///         Any signal can have any number of instances / objects / structs attached
///         to any number of signals.
///
///         If a an instance the signaler is supposed to signal is destroyed then
///         the signaler will auto-remove the signal at its next call.
///
/// @example    signaler = new Signaler(); // Create signaler
///             signaler.add_signal("some_signal", my_instance, my_instance.function, arg1);
///             signaler.signal("some_signal", arg0);
///
///             The above will effectively execute:
///             my_instance.function(arg0, arg1)
function Signaler() constructor{
    
    is_debug_output = false;	// If true, every signal outputs to the console when thrown
	is_initialized = true;      // Internal control variable
	signal_map = ds_map_create();	// Map of signal -> FuncRef connections
    
	function FuncRef(_name, _instance, _method) constructor{
	        // NOTE: the only time this should be set to "undefined" is if 
	        //       we remove a signal due to instance destruction
		my_function = (instance_exists(_instance) or is_struct(_instance)) ? method(_instance, _method) : undefined;
		name = _name;
		instance = _instance;
		my_method = _method;
		extra_args = [];
		if (argument_count == 4)
			extra_args = argument[3];
		
		function is_equal(_funcref){
			if (_funcref.name != name) return false;
			if (_funcref.instance != instance) return false;
			if (_funcref.my_method != my_method) return false;
			
			return true;
		}
	}
	
	/// @desc	Toggles whether to display debugging output for this signal
	///	@param	{bool}	output	true to output debugging info
	function set_debug_output(_output){
		is_debug_output = bool(is_debug_output);
	}
	
	///	@desc	Free data and mark as 'dead'.
	function free(){
		if (not is_initialized)
			return;
			
		is_initialized = false;
		
		// Delete all function references:
		var key = ds_map_find_first(signal_map);
		while (not is_undefined(key)){
			var a = signal_map[? key];
			for (var i = 0; i < array_length(a); ++i)
				delete a[i];
			
			key = ds_map_find_next(signal_map, key);
		}
		
		ds_map_destroy(signal_map);
	}

	///	@desc	Add an attachment to this signaler.
	///	@param	{string}			name		name of the signal to attach to
	///	@param	{real_or_struct}	instance	instance id or struct that owns the method to execute
	///	@param	{method}			method		method to execute
	///	@param	{any}				[args...]	optional values to pass to method when executed
	function add_signal(_name, _instance, _method){
		if (not is_initialized)
			throw "Cannot add signal to uninitialized Signaler!";
		
		var funcref;
		if (argument_count >= 4){
			var a = [];
			for (var i = 3; i < argument_count; ++i)
				a[array_length(a)] = argument[i];
			funcref = new FuncRef(_name, _instance, _method, a);
		}
		else
			funcref = new FuncRef(_name, _instance, _method);
		
		// If signals already exist here, 
		if (ds_map_exists(signal_map, _name)){
			var array = signal_map[? _name];
			
			var is_duplicate = false;
			for (var i = 0; i < array_length(array); ++i){
				if (array[i].is_equal(funcref)){
					is_duplicate = true;
					break;
				}
			}
			
			if (is_duplicate){
				delete funcref;
				return false;
			}
			
			// Add item to array:
			array[array_length(array)] = funcref;
			signal_map[? _name] = array;
		}
		// If first signal added, create an array:
		else{
			signal_map[? _name] = [funcref];
		}
		
		return true;
	}
	
	///	@desc	Remove a signal attachment from the system.
	///	@param	{string}			name		name of the signal to remove from
	///	@param	{real_or_struct}	instance	instance id or struct that owns the method to remove
	///	@param	{method}			method		method to remove
	function remove_signal(_name, _instance, _method){
		if (not is_initialized)
			throw "Cannot remove signal from uninitialized Signaler!";
		
		if (not ds_map_exists(signal_map, _name))
			return false;
		
		var return_value = false;
		var funcref = new FuncRef(_name, _instance, _method);
		
		var array = signal_map[? _name];
		for (var i = 0; i < array_length(array); ++i){
			if (array[i].is_equal(funcref)){
				return_value = true;
				
				var a2 = array_create(array_length(array) - 1);
				var offset = 0;
				// Create new array with value removed:
				for (var j = 0; j < array_length(array); ++j){
					if (j == i){
						offset = -1;
						continue;
					}
						
					a2[j + offset] = array[j];
				}
				
				// Update map:
				delete array[i];
				
				if (array_length(a2) == 0)
					ds_map_delete(signal_map, _name);
				else
					signal_map[? _name] = a2;
				break;
			}
		}
		
		delete funcref;
		return return_value;
	}
	
	/// @desc	Emits a signal to all attached method calls.
	///	@param	{string}	name		name of the signal to emit
	///	@param	{any}		[args...]	optional arguments to pass into the executed methods
	function signal(_name){
		if (not is_initialized)
			throw "Cannot call signal on uninitialized Signal!";
			
		if (not ds_map_exists(signal_map, _name))
			return false;
		
		var array = signal_map[? _name];
		if (is_debug_output) show_debug_message("[DEBUG] Throwing signal! ID [" + string(self) + "], NAME [" + _name + "], FROM OBJ [" + 
												object_get_name(other.object_index) + "], FROM INST [" + string(other.id) + "]");
		// Loop through each method attached:
		for (var i = 0; i < array_length(array); ++i){
			var f = array[i];

			if (not is_method(f.my_function)){ // Don't signal if it is an invalid method
				remove_signal(f.name, f.instance, f.my_method);
				continue;
			}

			if (not is_struct(f.instance) and not instance_exists(f.instance)){
				remove_signal(f.name, f.instance, f.my_method);
				continue;
			}
			
			// Print out debugging info:
			if (is_debug_output){
				var ob = undefined;
				var _in = undefined;
				if (instance_exists(f.instance)){
					_in = f.instance;
					ob = object_get_name(f.instance.object_index);
				}
				show_debug_message("\tTO OBJ [" + ob + "]" + ", TO INST [" + string(_in) + "], FNC ID [" + string(f.method) + "]");
			}
			
			// Execute actual methods:
			if (argument_count >= 2){
				var a = [];
				for (var j = 1; j < argument_count; ++j) // Add extra arguments
					a[array_length(a)] = argument[j];
					
				for (var j = 0; j < array_length(f.extra_args); ++j) // Add attached arguments
					a[array_length(a)] = f.extra_args[j];
				
				callv(f.my_function, a);
			}
			else
				callv(f.my_function, f.extra_args);
		}
	}
}