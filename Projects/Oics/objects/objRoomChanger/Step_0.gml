/// @description room change
if (position_meeting(objPlayer.x, objPlayer.y, id) and instance_exists(objPlayer))
{

	
	//go to new spawn point and get new facing
	global.roomTarget	= targetRoom;
	global.xSpawnTarget = targetX;
	global.ySpawnTarget = targetY;
	global.spawnFacing  = targetFacing;
	
	//transition start
	transition_start(global.roomTarget, sqFadeOut, sqFadeIn);
	
	//temporary mario phase
	InputManager.active = false;
	
}

