=== ABOUT:
Triggers are a simple way of executing code with built-in delay or repetition.
The implementation of triggers aims to add on to the GML syntax to allow a new language
feature by utilizing macros. Because the system uses macros there are some limits with
the syntax that should be observed.

1.	Using triggers MUST be used without parinthesis. I had to choose one or the other
	and figured no parinthesis would be less confusing to beginners.
2.	Specifying code after a trigger MUST be enclosed in a block, even if it is only
	one line of code. The block can be "{}" or "begin end".
3.	Each trigger must be closed with either the "attached" or "detached" keyword to
	let the system know the method of execution.

There are a number of trigger types depending on the keywords you use. The
differences will be in bold:

1.	trigger IN 10 seconds{} DETACHED;
	
	Triggers once in 10 seconds but can be re-triggered after each trigger.
	Code is detached from the object so it is executed even if the calling script is
	never accessed again.
	
	When in doubt, use this type.

2.	trigger IN 10 seconds{} ATTACHED;
	
	Triggers once in 10 seconds but can be re-triggered after each trigger.
	Code is attached to the object so this exact script must be called again in order
	to actually activate the trigger once the time has passed.
	
	Generally what you want if using triggers in step / draw events and order-of-
	execution really matters.

3.	trigger EVERY 10 seconds{} DETACHED;
	
	Begins an auto-loop where the trigger is constantly executed every 10 seconds until
	the calling object is destroyed.
	
	Not usually what you want unless you specifically want a loop to continue indefinitely.

4.	trigger EVERY 10 seconds{} ATTACHED;

	Begins a trigger loop that is auto-renewed like the detached version but it is NOT
	automatically executed unless the script is called again.
	
	Exactly the same as the detached method but must be continually called to execute.
	This allows pausing / stopping the trigger via an if statement.

5.	trigger ONCE in 10 seconds{} DETACHED;
	
	Triggers once in 10 seconds and will prevent resetting the trigger. The code
	will only ever be executed once.
	
	Only really useful for one-time events.

6.	trigger ONCE in 10 seconds{} ATTACHED;

	The same as the detached version but must be called once the timer is up in
	order to execute.
	
	Only really useful for one-time events where the logic constantly re-calculated
	in the step event.
	
=== SYNTAX:
The syntax of executing a trigger is as follows:

trigger <repetition> <time> <unit>{
	/* Code */
} <execution method>;

trigger once <repetition> <time> <unit>{
	/* Code */
} <execution method>;

Note that it is possible to nest triggers if you need this functionality.

=== KEYWORDS:
1.	trigger

	This keyword signifies you are defining a new trigger.
	
2.	<repetition> in, every

	The keyword 'in' will execute the trigger just once after
	the specified delay.
	The keyword 'every' will execute the trigger repeatedly after
	the specified delay.
	
	
3.	<unit> hour, minute, second, frame
	You can specify the delay to be measured in hours, minutes,
	seconds, or frames. Note that time-based measurements will be
	executed as close as possible to the specified time depending
	on the frame-rate.
	
4.	<execution method> attached, detached

	The 'attached' method attaches the code to the instance calling
	the trigger. This means that the trigger will be executed the next
	time THAT trigger definition is reached and the correct time has passed.
	This allows precise execution but requires that the trigger be defined in
	an event that is accessed often.
	The 'detached' method will execute the trigger regardless as to whether or
	not the trigger is seen again. You have less control as to when this event
	gets executed but you don't have to make sure the trigger is constantly
	accessed.
	
	A good example usage would be this. If you are placing a trigger in a looping
	event such as the step or draw, try 'attached' first. If you are creating a
	trigger in a once-off event like 'create' or a 'key press' then use a detached
	trigger.
	
5.	once

	This keyword, when placed after 'trigger' and follewed by 'in' will limit
	the trigger's execution to one time and will not allow re-execution of the
	trigger.
	
=== EXAMPLE 1:
// Trigger every 10 seconds so long as the trigger code is constantly executed:
trigger in 10 seconds{
	show_message("IT HAS BEEN 10 SECONDS!");
} attached;

=== EXAMPLE 2:
// Trigger every 30 frames regardless as to whether the code is accessed again:
trigger every 30 frames{
	show_message("IT HAS BEEN 30 FRAMES!");
} detached;

=== EXAMPLE 3:
// Trigger in 1 minute once and never again:
trigger once in 1 minute{
	show_message("IT HAS BEEN 1 MINUTE!");
} detached;

=== LIMITS:
There are some limits to using this system. First, as mentioned above, the syntax
must be exact in order to work. Secondly, temporary variables (variables created with
the 'var' keyword) are NOT accessible by the trigger if they are define outside the
trigger. Instance and global variables can be accessed just fine.

'attached' triggers will execute in the same place that they are defined. This means
your trigger code must be reached after the timer in order to actually be executed.

'detached' triggers will execute regardless as to whether or not the code is touched
again, however you lose control of execution event timing.

Triggers cannot currently have their times changed once created. You can set whatever
delay / time you wish but for a repeating trigger the time will remain the same once
the trigger has first been defined.