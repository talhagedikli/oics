/// @description 
//shader_set(shRainbow);

//shader_set_uniform_f(uniTime, current_time/1000);
//shader_set_uniform_f(uniX, x);
//shader_set_uniform_f(uniY, y);


draw_self();
draw_text(x, y, image_xscale);
draw_text(x, y + 15, image_yscale);
//shader_reset();


