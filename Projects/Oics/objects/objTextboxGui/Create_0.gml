//STOP and turn to who is talking to
with (objPlayer)
{
	//to save what direction I was looking to
	oldFacing = facing;
	
	//turn to who you are talking to
	var _d = sign(other.x-x);
	
	if (_d != 0)
	{
		facing = _d;
	}
	else
	{
		facing = oldFacing;
	}
	
	//stop while talking
	InputManager.active = false;
}
	
//variables
creator		= noone;
name		= noone;
sound		= noone;

text		= " ";
page		= 0;
charCount	= 0;

charSpd		= 0.5;

//some variables 
stringH		= string_height(text);

