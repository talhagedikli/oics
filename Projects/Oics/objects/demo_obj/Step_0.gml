if (keyboard_check_pressed(vk_up))
	signaler.signal("keyboard_up"); // Check create event for what this is

if (keyboard_check_pressed(vk_down)) // Check create event for why this one is different
	signaler.signal("keyboard_down", real(reference) - 1);
	
// Let's have a "hello" dialog show up once and only once! Now we could this
// in simpler ways but this shows off the one-time trigger:
trigger once in 2 seconds{
	show_message("Hello! This is a one-time delayed message in the step event!");
} attached;