function screen_flash(_dur) {
	control.flashDur = _dur;
}
	
// @description Stop game by specific time
function frame_freeze(_duration) {
	var _t = current_time + _duration;
	
	
	while (current_time < _t) 
	{
		
	}

}
	
