/// @description
//variables
global.midTransition	= false;
global.sequenceLayer	= noone;

global.roomTarget		= noone;
global.xSpawnTarget		= noone;
global.ySpawnTarget		= noone;
global.spawnFacing		= 1;

function transition_place_sequence(_type) {
	if (layer_exists("transitions"))	{ layer_destroy("transitions"); }
	var _lay = layer_create(-9999, "transitions");
	global.sequenceLayer = layer_sequence_create(_lay, camera_get_view_x(VIEW), camera_get_view_y(VIEW), _type);
}

function transition_start(_roomTarget, _typeOut, _typeIn) {
	if (!global.midTransition) {
		global.midTransition = true;
		global.roomTarget = _roomTarget;
		transition_place_sequence(_typeOut);
		layer_set_target_room(_roomTarget);
		transition_place_sequence(_typeIn);
		layer_reset_target_room();
		return true;
	} else {
		return false;
	}
}

function transition_change_room() {
	room_goto(global.roomTarget);
}

function transition_spawner() {
	objPlayer.x			= global.xSpawnTarget;
	objPlayer.y			= global.ySpawnTarget;
	objPlayer.facing	= global.spawnFacing;
}

function transition_finished() {
	layer_sequence_destroy(self.elementID);
	InputManager.active			= true;
	global.midTransition	= false;
}














	