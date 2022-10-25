/// @description 
///Text Input Create Script
//input storage variable
input			= "";
output			= undefined;
focus			= false;
maxCharacters	= 20;

// Bar variables
gap		= 10;
barW	= 200;
barH	= 20;
barX	= gap;
barY	= GUI_H - gap - barH;
textX	= barX + gap/2;
textY	= barY + gap/3;

//typeBar.create(10, GUI_H - 10, 200, -20);

// Cursor variables
barAlpha		= 1;
cursor			= "|";


// Command varialbes
command = undefined;
commlen = undefined;
value	= undefined;
type	= undefined;

// Last input
lastInput		= undefined;
fadeTimer		= 0;
fadeMax			= 20;
fadeX			= textX;
fadeXMax		= 215;

commList		= array_create(0);

global.test		= {
	
};

inputBar = new GuiBar();


// Methods to set and get variables for test struct
set_val = function (key, value) {
	global.test[$ key] = value;
}

get_val = function (variable, key) {
	static newvalue = undefined;
	var value = global.test[$ key];
	if (value == "undefined") value = undefined;

	newvalue = newvalue != value ? value : variable;
	
	if (global.test[$ key] != undefined)
		return newvalue;
	else 
		return variable;
	
}

checkType = function(value)
{
	enum str
	{
		digits,
		letters
	}
	static digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "-"];
	for (var i = 0; i < array_length(digits); i++)
	{
		if (value = digits[i])
		{
			return str.digits
		};
	}
	return str.letters;
}

// Player 
set_val("gasmax", undefined);
set_val("hmax", undefined);
set_val("vmax", undefined);
set_val("gspeed", undefined);

// Camera
set_val("camw", undefined);
set_val("camh", undefined);
set_val("camstate", undefined);

// Check to delete undefined values
repeatTime = 6000;
//alarm[0] = repeatTime;














