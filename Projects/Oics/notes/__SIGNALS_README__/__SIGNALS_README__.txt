===	ABOUT:
Signals are a great way to convert your active-monitoring code into passive
code that triggers once your event occurs.

You can think of Signaler as a fancy "scrip_execute" handler. It allows you
to attach a number of scripts and/or instances / structures to be executed
when a special keyword is thrown.

Signals also support declaration-timed arguments and execution-timed arguments
to be passed through your signals. This means you can specify arguments both when
creating the signal and when calling it and they will be passed to the executed
function.

In order to accomplish this there are two methods that accompany signalers:
1.	callv()
	This method takes a function and an array and will execute the function while
	passing each value of the array as if it was a normal argument.
	E.g., callv(instance_create_depth, [x, y, 0, dummy_obj]); 
	The above would effectively call:
	instance_create_depth(x, y, 0, dummy_obj);
2. callv_deferred()
	Acts the same as callv() but executes it on the following frame. An optional
	second-based delay can be specified to make the call wait even longer.

=== SYNTAX:
You can create a new signaler with "new Signaler()". You must manually call ".free()"
on a Signaler before deleting it as it will contain some management data that needs manual
cleanup.

===	EXAMPLE 1:
// [Create Event] of object_A:
	// Each object_A creates an empty Signaler:
	signaler = new Signaler();

// [CleanUp Event] of object_A:
	// Make sure we clean things up when instance is destroyed:
	signaler.free();
	delete signaler;

// [Collision Event] of object_A:
	// When we are hit we throw our signal saying who hit us!
	// It is up to other instances to "listen" for the signals, we just
	// send out the alert:
	signaler.signal("collision", other); // Pass collided object

// [Create Event] of object_B:
	// Create a function to handle when our friend object_A is hit!
	// We know object_A tells us who hits it as an argument so we take
	// that as our argument _collider.
	// We also will want to know WHICH object_A was hit so we will add
	// some extra data when connecting our signal  to be passed as 
	// the argument _inst.
	function fnc_hit(_collider, _inst){
		show_message(string(_collider) + " hit " + string(_inst));
	}

	// With each object_A tell its signaler we want to listen for the alert!
	// Note we pass the extra argument of 'id' at the end of the connection.
	// This makes sure that that value will always be passed as an argument
	// when the signal is thrown so we know who threw it!
	with (object_A)
		signaler.add_signal("collision", other.id, other.fnc_hit, id);
	
	// NOTE: You can also do inline functions when attaching a signal if you
	//		 want, albeit you can't manually remove those types of functions
	//		 and have to wait until the Signaler is destroyed.