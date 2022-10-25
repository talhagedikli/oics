/// @description player normal state
function player_state_normal()
{
	#region //Movement phase
	if (InputManager.keyLeft)
	{
		xSpeed = approach(xSpeed, -hMaxSpeed, aSpeed);
		facing = -1;
	}
	else if (InputManager.keyRight)
	{
		xSpeed = approach(xSpeed, hMaxSpeed, aSpeed);
		facing = 1;
	}
	else
	{
		xSpeed = approach(xSpeed, 0, dSpeed);
	}
	//calculating aSpeed and dSpeed
	if (onGround == true)
	{
		aSpeed = groundAccel;
		dSpeed = groundDecel;
	}
	else
	{
		aSpeed = airAccel;
		dSpeed = airDecel;
	}
	#endregion
	#region //Jumping phase
	//Coyote time
	if (onGround == false)
	{
		if (coyoteCounter > 0)
		{
			coyoteCounter -= 1;
		}
	}
	else
	{
		coyoteCounter = coyoteMax;
	}
	//real jump section
	if (InputManager.keySpace and canJump == true and coyoteCounter > 0)
	{
		ySpeed = jPower;
		canJump = false;
		//some jump effects(create if its on ground)
		if (onGround) part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1, 2, 3));
		squash_stretch(0.7, 1.3);
	}
	//to prevent the jump loop by holding down the key(canJump used for this)
	else if (!InputManager.keySpace and onGround == true)
	{
		canJump = true;
	}
	//jump buffer
	if (InputManager.keySpacePressed)
	{
		bufferCounter = bufferMax;
	}
	if (bufferCounter > 0)
	{
		bufferCounter -= 1;
		if (onGround == true)
		{
			bufferCounter = 0;
			ySpeed = jPower;
			//some jump effects 2
			part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1, 2, 3));
			squash_stretch(0.7, 1.3);
		}
	}
	//double jump section
	if (jumps > 0 and InputManager.keySpacePressed and doubleJump)
	{
		//reduce jumps variable by 1 every step
		jumps -= 1;
		ySpeed = jPower;
		squash_stretch(0.7, 1.3);
	}
	else if (onGround == true)
	{
		//set jumps variable to jumpsMax if it's on ground
		jumps = jumpsMax;
	}
	//variable jump height
	if (onGround == false)
	{
		if (ySpeed < 0 and!InputManager.keySpace && !InputManager.keyAlt)
		{
			//if InputManager.keySpace is not pressed, slow down by 50 percent
			ySpeed *= 0.95;
		}
	}
	//landed
	if (onGround == true)
	{
		if (landed == false)
		{
			//to track "just landed on ground" moment
			landed = true;
		}
	}
	else
	{
		//set landed back to false if it is on air
		landed = false;
	}
	#endregion
	#region //Flying section
	static _ptSystem = global.partSystem;
	static _pt = global.ptDashPixels;
	static time = 0;
	time++;
	if (InputManager.keyAlt)
	{
		if (gas > 0)
		{
			gas--;
			packPower = approach(packPower, packPowerMax, 0.005);
			if (time mod 5 == 0) //Creating some particles when flying
				part_particles_create(_ptSystem, x + random_range(-8, 8), y + sprite_yoffset, _pt, 1);
		}
		else
		{
			packPower = 0;
		}
		if (place_meeting(x, y - 1, objBlock)) packPower = 0; // If head hits roof, cut the power
	}
	else
	{
		packPower = 0;
		if (onGround)
		{
			gas = gasMax;
		}
	}
	gasBar.step(gas / gasMax, true);
	ySpeed -= packPower; // Apply packpower
	#endregion
	#region //Switching state phase
	//switch to crouch state
	//if (onGround and InputManager.keyDown) {
	//    squash_stretch(0.7, 1.2);
	//    state = states.crouch;
	//}
	////switch to dash state
	//if (keyDashPressed and canDash == true and stopDashing == false)
	//{
	//	frame_freeze(150);	
	//	screen_shake(5, 3, 1);
	//	state = states.dash;
	//}
	//else if (!keyDashPressed and onGround == true)
	//{
	//	canDash = true;
	//}
	if (InputManager.keyShiftPressed)
	{
		if (InputManager.horizontalInput == 0 && InputManager.verticalInput == 0)
		{
			dashDir.find(facing, 0);
		}
		else
		{
			dashDir.find(InputManager.horizontalInput, InputManager.verticalInput);
		}
		isDashing = true;
		state = states.dash;
	}
	////switch to grab state
	//if (onWall and keyGrab and onGround == false and stopGrabbing == false)
	//{
	//	//cangrab = false;
	//	state = states.grab
	//}
	//else if (onGround == true)
	//{
	//	//cangrab = true;
	//	canClimb = true;
	//	grabCounter = 0;
	//}
	#endregion
}
/// @description player dash state
function player_state_dash()
{
	dashTween.sstart(0, dashPower, 0.25);
	xSpeed = lengthdir_x(dashTween.value, dashDir.angle);
	ySpeed = lengthdir_y(dashTween.value, dashDir.angle);
	//var dt = distance_to_point(lengthdir_x(dashPower, dashDir.angle), lengthdir_y(dashPower, dashDir.angle));
	//var ps = distance_to_point(xSpeed, ySpeed);
	ghostDashTimer.sstart(0.25 / 4);
	if ghostDashTimer.done
	{
		part_particles_create(global.partSystem, x, y, global.ptGhostDash, 1);
		ghostDashTimer.reset();
	}
	show_debug_message(dashTween.value);
	//if dashTween.value == 0 show_message("done");
	if (dashTween.done || (onWall && xSpeed != 0))
	{
		ghostDashTimer.reset();
		dashTween.reset();
		isDashing = false;
		state = states.normal;
	}
}
/// @description player crouch state
function player_state_crouch()
{
	xSpeed = approach(xSpeed, 0, crouchDecel);
	//from cube
	squash_stretch(1.4, 0.6);
	//switch statement
	if (!InputManager.keyDown)
	{
		state = states.normal;
	}
}
/// @description
function player_animation_control()
{
	xScale = approach(xScale, 1, 0.03);
	yScale = approach(yScale, 1, 0.03);
	//animation control    
	switch state
	{
		case states.normal: if (InputManager.keyLeft)
		{
			facing = -1;
		}
		else if (InputManager.keyRight)
		{
			facing = 1;
		}
		if (onGround)
		{
			if (InputManager.keyLeft or InputManager.keyRight)
			{
				sprite = sprPlayer;
			}
			else
			{
				sprite = sprPlayer;
			}
		}
		else
		{
			sprite = sprPlayer;
			if (ySpeed < -1)
			{
				frame = 2;
			}
			else if (ySpeed > 1)
			{
				frame = 1;
			}
			else
			{
				frame = 0;
			}
		}
		/*/SOUND
		if (keyJump) 
		{
			if (!audio_is_playing(aJump))
			{
				audio_play_sound(aJump, 2, false);
			}
				
		}
		else 
		{
			audio_stop_sound(aJump);
		}*/
		break;
		case states.crouch: sprite_index = sprPlayerCrouch;
		break;
		case states.dash:
			/* çıkartıldı çünkü dash esnasında değişmemesi gerek(bunun yerine isDashing
			de olabilirdi)
			if (keyLeft)
			{
	            facing = -1;
	        }
			else if (keyRight)
			{
	            facing = 1;
	        }
			*/
			sprite = sprPlayer;
		break;
	}
	//reset frame to 0 if sprite changes
	if (lastSprite != sprite)
	{
		lastSprite = sprite;
		frame = 0;
	}
}