///	@desc	The _ref class allow storing and sharing values by 'reference'. 
///			This allows various scripts to modify the same value without having
///			to constantly update a variable. Any variable containing the reference
///			will have the updated value.
///
/// @NOTE:	This struct should not be called manually, instead you should create the
///			struct with:
///			var my_ref = ref(10);
///
///			You can then destroy the struct with:
///			deref(my_ref);
///
///			References can be passed into conversion functions and it will return the
///			value stored inside. So, for example:
///			var my_ref = ref(10);
///
///			var another_value = real(my_ref);
///
///			The variable another_value would contain the number 10.
function _ref() constructor{
	magic_string = "2GbFUbRRGSNW";
	value = (argument_count > 0) ? argument[0] : undefined;
	count = 1; // Number of attachments
	
	///	@desc Set the value of the reference
	///	@param	{any}	value	value to use
	function set(_value){
		value = _value;
	}
	
	///	@desc	Returns the value stored in the reference
	function get(){
		return value;
	}
	
	/// @desc	Increment attachment and return self.  ONLY do this
	///			if you plan on keeping track of decrementing the count again!
	///
	///			If you need to guarantee the value's existence in a script you
	///			can pass my_ref.inc() instead of just my_ref. At the end of the
	///			script make sure to call my_ref.dec()
	function inc(){
		count += 1;
		return self;
	}
	
	/// @desc	Decrement attachment and return self. ONLY do this if
	///			you know what you are doing! If count <= 0 the structure is
	///			automatically freed.
	function dec(){
		count -= 1;
		
		// If the count is less than 0, destroy the
		// ref from memory next frame
		if (count <= 0)
			callv_deferred(deref, [self]);
			
		return self;
	}
	
	/// Allow natural conversion of stored value when
	/// referenced w/ string(), real(), int64, etc.
	function toString(){
		return string(value);
	}
}

///	@desc	Creates a new reference out of the provided value
///			and returns the result.
///	@param	{any}	value	value to store
///	@return	{ref}
function ref(){
	if (argument_count == 0)
		return new _ref();
	else
		return new _ref(argument[0]);
}

///	@desc	Returns the value stored in the specified reference.
///			If no more attachments exist then the structure it will be
///			auto freed.
///	@param	{ref}	ref		reference to free
///	@return	{any}
function deref(_ref){
	if (not is_ref(_ref))
		return undefined;
		
	var value = _ref.get();
	
	if (_ref.count - 1 <= 0)
		delete _ref;
	else
		_ref.dec();
		
	return value;
}

///	@desc	Returns, to the best of the system's ability, if the specified
///			value is a reference.
///			This function is mildly slow in repetative loops.
function is_ref(_value){
	if (not is_struct(_value))
		return false;
		
	if (not variable_struct_exists(_value, "magic_string"))
		return false;
		
	if (_value.magic_string != "2GbFUbRRGSNW")
		return false;
		
	return true
}