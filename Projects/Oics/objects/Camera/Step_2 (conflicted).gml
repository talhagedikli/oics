switch (mode)
{
	case cam.cell:
	mode_cell();
	break;
	
	case cam.normal:
	mode_normal();
	break;
}
	
//get cam's current position in case
var _curX = camera_get_view_x(VIEW);
var _curY = camera_get_view_y(VIEW);
	
//track the transition layer
if (layer_sequence_exists("transitions",global.sequenceLayer)) {
	layer_sequence_x(global.sequenceLayer,_curX);
	layer_sequence_y(global.sequenceLayer,_curY);
}
