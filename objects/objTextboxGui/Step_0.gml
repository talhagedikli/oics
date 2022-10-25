//gui width and height
if (keyboard_check_pressed(vk_down) or gamepad_button_check_pressed(0, gp_padd))
{
	//only increase if page+1 is less than the total number
	if (charCount < string_length(text[page]))
	{
		charCount = string_length(text[page]);
	}
	else if (page + 1 < array_length(text))
	{
		page += 1;
		charCount = 0;
	}
	else
	{
		instance_destroy();
		//make myTextbox is equal to noone again. instead of that do that
		creator.alarm[0] = 1;
	}
}

//get out of the conversation
if (keyboard_check_pressed(vk_up) or gamepad_button_check_pressed(0, gp_padu))
	{
		instance_destroy(id);
	}
//character speak sounds
if (charCount mod 3 == 0)
{
	audio_play_sound(sound, 1, false);
	audio_sound_pitch(sound ,choose(0.8, 1));
}


