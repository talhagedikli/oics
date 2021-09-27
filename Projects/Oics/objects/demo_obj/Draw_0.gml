draw_circle_color(mouse_x, mouse_y, 32, mouse_color, mouse_color, is_mouse_outline);

// If the user holds the mouse let's change the color, but only allow a switch
// every 30 frames:
if (mouse_check_button(mb_left)){
	trigger in 30 frames{
			var nc = mouse_color;
			while (nc == mouse_color)
				nc = choose(c_red, c_blue, c_green, c_lime, c_aqua, c_purple, c_orange);
				
			mouse_color = nc;
	} attached; 
	// The 'attached' means that we have to be in this exact piece of code in order
	// for the trigger to go off and execute the code after 30 frames. This means
	// that it only goes off if the mouse is being held.
}

if (mouse_check_button_pressed(mb_right)){
	trigger in 1 second{
		is_mouse_outline = not is_mouse_outline;
	} detached;
	// The 'detached' means that the trigger will go off no matter what we do
	// so long as we don't destroy this instance. This means we don't have to
	// keep clicking the right button to have the trigger go off, unlike the
	// 'attached' method.
}