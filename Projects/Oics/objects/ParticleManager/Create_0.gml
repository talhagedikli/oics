/// @description 
/// @description
global.partSystem = part_system_create();

#region//example particle
	var _p = part_type_create();
	
	part_type_shape(_p, pt_shape_disk);
	part_type_life(_p, 20, 40);
	part_type_scale(_p, 0.3, 0.3);
	
	part_type_alpha2(_p, 1, 0);
	part_type_color2(_p, c_red, c_white);
	//part_type_size(_p, 0.05, 0.1, 0.025, 0);	//max min size just start, then it grows
	
	part_type_speed(_p, 0.5, 1, 0, 0,);
	part_type_direction(_p, 0, 360, 0, 0);
	part_type_gravity(_p, 0.1, 270);
	
	global.ptBasic = _p;
	
	//trail particle
	var _p = part_type_create();
	
	part_type_shape(_p, pt_shape_circle);
	part_type_life(_p, 40, 50);
	part_type_size(_p, 0.4, 0.4, -0.02, 0.05);
	
	global.ptTrail = _p;
	
	//set as step
	part_type_step(global.ptBasic, 1, global.ptTrail);
	
	//death explosion
	var _p = part_type_create();
	
	part_type_shape(_p, pt_shape_flare);
	part_type_life(_p, 30, 40);
	part_type_size(_p, 0.3, 0.4, 0.08, 0);
	part_type_alpha3(_p, 0.8, 1, 0);
	part_type_blend(_p, true);
	
	global.ptDeathExplosion = _p;
	
	//set as death
		part_type_death(global.ptBasic, 1, global.ptDeathExplosion);
		#endregion
	
#region//dash pixels
	var _p = part_type_create();
	
	part_type_shape(_p, pt_shape_pixel);
	part_type_life(_p, 40, 50);
	part_type_scale(_p, 1.5, 1.5);
	
	part_type_alpha3(_p, 0.7, 1, 0);
	//part_type_color2(_p, c_red, c_white);
	//part_type_size(_p, 0.05, 0.1, 0.025, 0);	//max min size just start, then it grows
	
	part_type_speed(_p, 0.5, 1, -0.05, 0,);
	part_type_direction(_p, 0, 360, 0, 0);
	part_type_gravity(_p, 0.05, 270);
	
	global.ptDashPixels = _p;
	#endregion
	
#region//dirt particle
	var _p = part_type_create();
	
	part_type_shape(_p, pt_shape_cloud);
	part_type_life(_p, 25, 30);
	//part_type_scale(_p, 0.1, 0.1);
	part_type_size(_p, 0.1, 0.1, -0.001, 0);
	
	part_type_alpha3(_p, 0.7, 1, 0);
	//part_type_color2(_p, c_red, c_white);
	//part_type_size(_p, 0.05, 0.1, 0.025, 0);	//max min size just start, then it grows
	
	part_type_speed(_p, -0.5, 0.5, 0, 0,);
	part_type_direction(_p, 0, 180, 0, 0);
	part_type_gravity(_p, 0.005, 90);
	
	global.ptDirt = _p;
#endregion

#region// Ghost Dash
	var _p = part_type_create();
	
	part_type_sprite(_p, sprPlayer, false, false, false);
	part_type_life(_p, 12, 15);
	
	part_type_alpha3(_p, 0.7, 1, 0);
	
	global.ptGhostDash = _p;

	
	//set as death
	part_type_death(global.ptGhostDash, 1, global.ptDashPixels);
	
#endregion
	


