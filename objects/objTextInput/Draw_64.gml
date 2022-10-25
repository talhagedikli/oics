/// @description Display the bar and input text

barX	= gap;
barY	= GUI_H - gap - barH;
textX	= barX + gap/2;
textY	= barY + gap/3;

// Draw bar
draw_set_alpha(barAlpha);
draw_set_color(c_dkgray);
//drawBar(10, GUI_H - 10, 200, -20, noone, "horizontal", true, C_SHADOW, barAlpha, false, false);
inputBar.draw(10, GUI_H - 10, 200, -20, "horizontal", C_SHADOW, barAlpha, true, false);

// Draw the last input
if (lastInput != undefined) 
{
	fadeX = flerp(fadeX, fadeXMax, 0.2);
	draw_set_alpha(fadeTimer / fadeMax * barAlpha);
	draw_set_color(c_white);
	draw_set_font(fntText);
	draw_text(fadeX, textY, lastInput);
	
	if (fadeX == fadeXMax) fadeTimer -= 0.5;
	
}

// Draw input
draw_set_alpha(barAlpha);
draw_set_color(c_white);
draw_set_font(fntText);
draw_text(textX, textY, input + cursor);

// Reset vars
draw_set_alpha(1);
draw_set_color(c_white);