/// @description 
if (keyboard_check_pressed(vk_tab))
{
	focus = !focus
}
if (focus = true)
{
	if (string_length(keyboard_string) < maxCharacters) input = keyboard_string;
	if (keyboard_check_pressed(vk_enter))
	{
		focus = false;
		output = string_copy(input, 1, maxCharacters);
		lastInput = output;
		input = "";
		keyboard_string = input;
		fadeX = 15;
		fadeTimer = fadeMax;
	}
}
if (focus)
{ // Stuff to do in focus mode
	InputManager.active = false;
	cursor = current_time / 100 mod 10 > 5 ? "|" : "";
	barAlpha = lerp(barAlpha, 0.8, 0.1);
	if (keyboard_check_pressed(vk_escape))
	{
		focus = false
	}
}
else
{ // Stuff to do in !focus mode
	InputManager.active = true
	cursor = "";
	barAlpha = flerp(barAlpha, 0.2, 0.1);
	input = "";
	keyboard_string = input;
}