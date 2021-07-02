/// @description 
/// @description 

if (active) 
{
	horizontalInput	= (keyboard_check(vk_right) - keyboard_check(vk_left));		// Will be -1, 0 or 1
	verticalInput	= (keyboard_check(vk_down) - keyboard_check(vk_up));		// Will be -1, 0 or 1

	keyRight			= RIGHT;
	keyLeft				= LEFT;
	keyDown				= DOWN;
	keyUp				= UP;

	keySpace			= SPACE;
	keyAlt				= ALT;
	keyR				= keyboard_check(ord("R"));
	keyEsc				= keyboard_check(vk_escape);
	keyShiftPressed		= keyboard_check_pressed(vk_shift);

	keyRightPressed		= RIGHT_PRESSED;
	keyLeftPressed		= LEFT_PRESSED;
	keyDownPressed		= DOWN_PRESSED;
	keyUpPressed		= UP_PRESSED;

	keySpacePressed		= SPACE_PRESSED;
	keyAltPressed		= ALT_PRESSED;
	keyRPressed			= keyboard_check_pressed(ord("R"));
	keyEscPressed		= keyboard_check_pressed(vk_escape);
} 
else 
{
	keyRight			= noone;
	keyLeft				= noone;
	keyDown				= noone;
	keyUp				= noone;
						  
	keySpace			= noone;
	keyAlt				= noone;
	keyR				= noone;
	keyEsc				= noone;
	keyShiftPressed		= noone;
						  
	keyRightPressed		= noone;
	keyLeftPressed		= noone;
	keyDownPressed		= noone;
	keyUpPressed		= noone;
						  
	keySpacePressed		= noone;
	keyAltPressed		= noone;
	keyRPressed			= noone;
	keyEscPressed		= noone;
}



