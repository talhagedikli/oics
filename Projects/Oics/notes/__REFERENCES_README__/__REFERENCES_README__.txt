===	ABOUT:
References are simple structures that aim to help simulate passing values
by reference. You can create a reference, pass it around, and then destroy
it as needed.

References also have the added benefit of allowing for conversion of their
data as you would a normal variable.

For example, if you had the reference "R" storing the value 10 any of the
following lines would work as expected:

show_message(R); // Print out "10"
show_message(5 + real(R)); // Print out "15"

References make for a simple and easy-to-use wrapper that allows sharing values
between scripts / objects / structs w/o having to manually pass the updated values
back and forth.

=== SYNTAX:
To create a reference just wrap your value in the "ref()" function. You
must MANUALLY destroy your reference when done with "deref()".

If you plan on passing your reference around and don't want to risk some
other script freeing the reference too early you can increment its 
'reference counter' each time you pass it around with ".inc()" and then
decrement the reference counter with ".dec()" once that script is done with it.

=== EXAMPLE 1:
// A basic 'pass by reference' example:
var R = ref(10);

function add_10(_value){
	_value.set(real(_value) + 10);
}

add_10(R);
show_message(R); // Print out 20
deref(R); // Free reference, returns value if needed

=== EXAMPLE 2:
// Prevent early freeing:
var R = ref(10);
with (some_object)
	copy_of_reference = R.inc(); // Increment count to prevent early free
	
deref(R);	// Because "some_object" called .inc() the reference will stay
			// in memory until "some_object" calls .dec() on the reference.