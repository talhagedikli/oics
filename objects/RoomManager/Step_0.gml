switched = checkRoom();

if (switched)
{
	state.change(room_get_name(room));
	currentRoom = room;	
}

state.step();





