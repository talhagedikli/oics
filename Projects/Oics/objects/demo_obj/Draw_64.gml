// Lets loop through our stored FPS values and print them out!
framerate_average = 0; // This will be the average of all stored framerates
framerate_string = "";

iterate framerate_queue forward{
	// NOTE: Iterating over something provides
	//		 the variable 'it' automatically!
	//		 You can modify the value w/ it.set()
	//		 and fetch the value manually w/ it.get()
	framerate_string += "FPS: " + string(it) + "\n";
	framerate_average += real(it);
	
	// The 'it' variable is an example usage of the ref()
	// system! If you modify the value in it it will update
	// it in the structure as well!
} itt_ds_queue;

framerate_average /= max(1, ds_queue_size(framerate_queue));

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_text(10, 10, "Average: " + string(framerate_average) + "\nFramerates:\n\n" + framerate_string);

draw_set_halign(fa_right);
draw_text(room_width - 10, 10, "Hold [left-mouse] to change the circle's color!");
draw_text(room_width - 10, 10, "\nPress [right-mouse] to switch circle outline after 1-second delay!");


draw_set_valign(fa_bottom);
draw_text(room_width - 10, room_height - 10, "Our reference array: " + string(reference_array) + "\nPress [up-arrow] to increment the reference\nPress [down-arrow] to decrement the reference");
