/// @description Insert description here
// You can write your code in this editor

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check(vk_space);
key_jump_release = keyboard_check_released(vk_space);
key_skate_released = (keyboard_check_released(vk_left) || keyboard_check_released(vk_right));
grounded = place_meeting(x,y+1,obj_wall);

hsp = (key_right - key_left) * skateSpd;
vsp += grv;


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
			if(hsp != 0) {
				animState = ANIM_SKATE;
				sprite_index = spr_skater;
			} else {
				animState = ANIM_IDLE;
				sprite_index = spr_skateridle;
			}
		}
	break;
	case ANIM_CROUCH:
		if(key_jump_release)
		{
			vsp += jmpSpd;
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



// Collisions
if(place_meeting(x + hsp, y, obj_wall)) {
	while(!place_meeting(x + sign(hsp), y, obj_wall))
	{
		x += sign(hsp);
	}
	hsp = 0;
}

if(place_meeting(x, y + vsp, obj_wall)) {
	while(!place_meeting(x, y + sign(vsp), obj_wall))
	{
		y += sign(vsp);
	}
	vsp = 0;
}


// Update position
x += hsp;
y += vsp;

// Check direction
image_xscale = sign(hsp);
if(image_xscale == 0) 
{
	image_xscale = lastDir;
}
lastDir = image_xscale;




