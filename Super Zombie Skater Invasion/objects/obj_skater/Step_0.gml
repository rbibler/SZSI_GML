/// @description Insert description here
// You can write your code in this editor
var bbox_side;

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check(vk_space);
key_jump_release = keyboard_check_released(vk_space);
key_skate_released = (keyboard_check_released(vk_left) || keyboard_check_released(vk_right));
grounded = tilemap_get_at_pixel(colTiles,x,bbox_bottom + 1);
if(grounded && !groundedLast) 
{
	landingStep = currentStep		
}
groundedLast = grounded;
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
		if(key_jump) 
		{
			jumpImpulse += jumpImpulseInc;
			if(jumpImpulse <= jumpSpd) 
			{
				jumpImpulse = jumpSpd;
			}
		}
		if(key_jump_release)
		{
			if(currentStep - landingStep <= 5)
			{
				jumpImpulse += (jumpSpd * .5);
				if(jumpImpulse <= jumpSpd) 
				{
					jumpImpulse = jumpSpd;
				}
			}
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

currentStep++;

if(xsp > 0) 
{
	bbox_side = bbox_right;
} else 
{
	bbox_side = bbox_left;
}

if(tilemap_get_at_pixel(colTiles,bbox_side+xsp,bbox_top) != 0) || (tilemap_get_at_pixel(colTiles,bbox_side+xsp,bbox_bottom) != 0)
{
	if(xsp > 0)
	{
		x = x - (x % 16) + 15 - (bbox_right - x);
	} else
	{
		x = x - (x % 16) - (bbox_left - x);
	}
	xsp = 0;
	speed_x = 0;
}

if(ysp > 0) 
{
	bbox_side = bbox_bottom;
} else 
{
	bbox_side = bbox_top;
}

if(tilemap_get_at_pixel(colTiles,bbox_left,bbox_side+ysp) != 0) || (tilemap_get_at_pixel(colTiles,bbox_right,bbox_side+ysp) != 0)
{
	if(ysp > 0)
	{
		y = y - (y % 16) + 15 - (bbox_bottom - y);
	} else
	{
		y = y - (y % 16) - (bbox_top - y);
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




