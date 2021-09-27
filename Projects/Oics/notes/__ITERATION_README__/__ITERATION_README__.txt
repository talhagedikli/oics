=== ABOUT:
Iterators are an automated way of looping through a number of elements
in an array or supported data structure.

NOTE: To those coming from languages with actual iterators these do not
	  work quite the same as you can not manually traverse iterators, just
	  get / set their values.
	  
When looping your loop is provided with the variable "it" that represents the
iterator for the current value in the loop. You can get the variable stored
at that location in your structure by calling it.get(). You can also modify
the value by setting it in the iterator with it.set(new_value).

When traversing ds_maps iterators will contain a struct containing two values:
{
	key		: [key of the current value]
	value	: [value of the current key] 
}
Both can be modified and it will adjust the map accordingly.

=== SYNTAX:
The syntax of looping a structure is as follows:

iterate <structure> <direction>{
	/* Code */
} <structure type>;

Note that it is possible to nest loops for structures like
multi-dimensional arrays.

=== KEYWORDS:
1.	iterate
	This keyword signifies you are starting a new iterative loop.
2.	<direction> forward, backward
	The keyword 'forward' will loop bottom-up through the structure
	The keyword 'backward' will loop top-down through the structure
	NOTE: ds_maps are NOT ordered so results may not be as expected!
3. <structure type> itt_array, itt_ds_list, itt_ds_map, itt_ds_queue, itt_ds_stack
	The type of structure the iteration loop should expect.

=== EXAMPLE 1:
// Print out "1 2 3 4"
var list = ds_list_create();
ds_list_add(1, 2, 3, 4);

iterate list forward{
	show_debug_message(it);
} itt_ds_list;

ds_list_destroy(list);

=== EXAMPLE 2:
// Print "2 1 4 3 6 5"
var array = [[1, 2], [3, 4], [5, 6]];
iterate array forward{
	iterate it.get() backward{
		show_debug_message(it);
	} itt_array;
} itt_array;

=== EXAMPLE 3:
// Change all values in the queue to negatives:
var queue = ds_queue_create();
for (var i = 1; i < 10; ++i) // Fill queue
	ds_queue_enqueue(queue, i);

iterate queue forward{
	it.set(-it.get());
} itt_ds_queue;

ds_queue_destroy(queue);

=== EXAMPLE 4:
// Change all map entries to "bar"
var map = ds_map_create();
map[? "a"] = "foo";
map[? "b"] = "foo";
map[? "c"] = "foo";
iterate map forward{
	it.get().value = "bar";
} itt_ds_map;

ds_map_destroy(map);

=== LIMITS:
Using an iterative loop is significantly more expensive than using
a for loop due to the extra logic, multiple set/get calls of the structure,
and having to dynamically call methods. Measurements show about 1/9th the speed
of a for loop.

Iterative loops do NOT have access to temporary variables (variables created with
the 'var' keyword) that are defined outside the loop. Instance and global variables
can be accessed just fine.

Currently you only have access to the current iterator in a nested loop, adding access
to iterators up the tree is possible but would add further complexity and speed hits. If
you need this functionality it is suggested you store the iterator you will need in a local
variable before starting the next iterative loop.