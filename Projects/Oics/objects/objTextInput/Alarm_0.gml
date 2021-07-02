/// Check global struct
var i = 0; repeat (array_length(commList)) {
	if (global.test[$ commList[@ i]] == undefined) {
		variable_struct_remove(global.test, commList[@ i]);
		array_delete(commList, i, 1);
	}
	i++;

}

alarm[0] = repeatTime;