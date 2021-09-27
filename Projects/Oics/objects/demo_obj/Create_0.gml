// Let's make a queue that stores the last 5 recorded framerates
// so we can print them out and grab the average:
framerate_queue = ds_queue_create();

// Let's update this queue just once a second:
trigger every 1 second{
	// Add our new framerate:
	ds_queue_enqueue(framerate_queue, fps_real);
	
	// If more than 5, delete until we are at 5:
	while (ds_queue_size(framerate_queue) > 5)
		ds_queue_dequeue(framerate_queue);
} detached;
	// NOTE: See the 'detached'? This means we are detaching the timer code from this object and it
	//		 will be executed automatically elsewhere.
	//		 Using the 'attached' method wouldn't work in the create event because this code would
	//		 never be checked again!
	
// Properties for the circle that follows our mouse:
mouse_color = c_white;
is_mouse_outline = false;

// Here is a very simple example of using a reference:
reference = ref(10);
reference_array = [reference, reference, reference];
	// Now in the step event we will modify the reference w/ arrow keys and
	// it will update every spot in the array!
	// Also note how we DON'T have to do anything special for the array to display
	// in the HUD correctly? Using string(), real(), etc on a reference will automatically
	// apply it to the value stored inside the reference, not the reference itself.
	
// Signals are a great way to have objects communicate with eachother passively.
// To keep things simple we are just going to make a Signaler handle updating our
// reference but you would normally tie a number of instances and/or structs
// together instead:
signaler = new Signaler();
	// The first example, when the signal "keyboard_up" is thrown it will
	// execute this custom function and automatically pass the structure into
	// it to be modified:
signaler.add_signal("keyboard_up", id, function(_reference){
	_reference.set(real(_reference) + 1);
}, reference);
	// This second example actually attaches it directly to the reference's 
	// "set()" function and we will pass in the new value ourselves when
	// the signal is thrown.
signaler.add_signal("keyboard_down", reference, reference.set);

// There are a number of ways to connect things and you can attach any number
// of instances or structs to any number of signals.