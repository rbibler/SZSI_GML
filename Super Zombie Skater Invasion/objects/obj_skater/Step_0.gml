/// @description Insert description here
// You can write your code in this editor

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check(vk_space);
key_jump_release = keyboard_check_released(vk_space);
key_skate_released = (keyboard_check_released(vk_left) || keyboard_check_released(vk_right));
grounded = place_meeting(x,y+1,obj_wall);

// Acceleration
var spd_wanted = 0;

speed_y += yAccel;
spd_wanted = (key_right - key_left) * skateSpdMax;



// Handle Animation
switch(animState) 
{
	case ANIM_IDLE:
		if(key_jump) 
		{
			animState = ANIM_CROUCH;
			sprite_index = spr_skatercrouch;
		} else if(key_left || key_right) 
		{
			animState = ANIM_SKATE;
			sprite_index = spr_skater;
		} else 
		{
			sprite_index = spr_skateridle;
		}
	break;
	case ANIM_SKATE:
		if(key_jump) 
		{
			animState = ANIM_CROUCH;
			sprite_index = spr_skatercrouch;
		}
		if(key_skate_released)
		{
			animState = ANIM_IDLE;
			sprite_index = spr_skateridle;
		}
	break;
	case ANIM_JUMP:
		if(grounded)
		{
			if(spd_wanted != 0) {
				animState = ANIM_SKATE;
				sprite_index = spr_skater;
			} else {
				animState = ANIM_IDLE;
				sprite_index = spr_skateridle;
			}
		}
	break;
	case ANIM_CROUCH:
		jumpImpulse += jumpImpulseInc;
		if(jumpImpulse <= jumpSpd) 
		{
			jumpImpulse = jumpSpd;
		}
		if(key_jump_release)
		{
			speed_y = jumpImpulse;
			jumpImpulse = jumpImpulseMin;
			animState = ANIM_JUMP;
			sprite_index = spr_skaterjump;
		}
	break;
	case ANIM_BAIL:
	break;
	case ANIM_FALL:
	break;
	case ANIM_FLIP:
	break;
	case ANIM_SLAM:
	break;
}

speed_x += (spd_wanted - speed_x) * xAccel;

var ysp = round(speed_y);
var xsp = round(speed_x);



// Collisions
if(place_meeting(x + xsp, y, obj_wall)) {
	while(!place_meeting(x + sign(xsp), y, obj_wall))
	{
		x += sign(xsp);
	}
	xsp = 0;
	speed_x = 0;
}

if(place_meeting(x, y + ysp, obj_wall)) {
	while(!place_meeting(x, y + sign(ysp), obj_wall))
	{
		y += sign(ysp);
	}
	ysp = 0;
	speed_y = 0;
}


// Update position
x += xsp;
y += ysp;

deltaX = x - lastX;
lastX = x;
// Check direction
image_xscale = sign(xsp);
if(image_xscale == 0) 
{
	image_xscale = lastDir;
}
lastDir = image_xscale;




