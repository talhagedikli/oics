/// @description 
//if keyboard_check_pressed(vk_shift) {
//	menuLevel++;
//	menuLevel = menuLevel mod menus.length;
//}


var length	= array_length(menu[menuLevel]);
var midX	= 10;
var midy	= 10;

var i = 0; repeat (length) {
	draw_set_valign(fa_left);
	draw_set_halign(fa_left);
	draw_set_font(fntMenu);
	
	var c = pos == i ? C_CRIMSON : c_white;
	var a = pos == i ? asin(current_time / 10) : 1;
	
	
	draw_text_color(midX, midy + i*(string_height("TEST") + 1), menu[menuLevel][i], c, c, c, c, a);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_alpha(1);
	
	
	i++;	
}