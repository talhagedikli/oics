if (place_meeting(x,y,objPlayer))
{
	//if textbox does not exists
	if (myTextbox == noone and keyboard_check_pressed(vk_down))
	{
		myTextbox = instance_create_layer(x, y, "text", objTextboxGui);
		myTextbox.text = myText;
		myTextbox.creator = id;
		myTextbox.name = myName;
		myTextbox.sound = mySound;
		zoom_in(id);
	}
}
else
{
	if (myTextbox != noone)
	{
		instance_destroy(myTextbox);
		myTextbox = noone;
	}
	
	
}