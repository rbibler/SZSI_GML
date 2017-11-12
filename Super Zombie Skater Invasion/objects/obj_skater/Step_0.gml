/// @description Insert description here
// You can write your code in this editor

// Collision variables
var p1,p2,bbox_side;
var cur_x_accel = xAccel;

// Check user input
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check(vk_space);
key_jump_release = keyboard_check_released(vk_space);
key_skate_released = (keyboard_check_released(vk_left) || keyboard_check_released(vk_right));

// We're on the ground if bottom left, bottom right, or bottom center points are more than 0 pixels into a tile
var groundedBottom = (InFloor(colTiles,x,bbox_bottom+1) >= 0);
var groundedLeft = (InFloor(colTiles,bbox_left,bbox_bottom+1) >= 0);
var groundedRight = (InFloor(colTiles,bbox_right,bbox_bottom+1) >= 0);
grounded = groundedBottom || groundedLeft || groundedRight;

// If we're on the ground, we can jump


// Acceleration
var spd_wanted = 0;
// Add gravity on each step
speed_y += yAccel;

// Enforce a terminal velocity. Any faster and we could go through a tile
if(speed_y >= 16) {
	speed_y = 16;
}

var cur_direction = (key_right - key_left);
// If we're on the ground, respond to user's horizontal input directly. If in air, slow it down
spd_wanted = (key_right - key_left) * skateSpdMax;

if (!grounded)
{
	if( sign(spd_wanted) != sign(speed_x))
	{
		spd_wanted *= 0.75;
	}
} 


if (jmp_count > 0 || can_wall_jump)
{
	// Jump when jump key is released
	if(key_jump_release)
	{
		
		var wall_jump_cool = !grounded && can_wall_jump && (cur_direction + wall_jmp_direction) == 0;
		
		if(jmp_count > 0 || wall_jump_cool) 
		{
		
			// Set vertical speed to the currently stored jump impulse to jump
			speed_y = jumpImpulse;
			jumpImpulse = jumpImpulseMin; 
			crouch_count = 0;
			animState = ANIM_JUMP;
			sprite_index = spr_skaterjump;
			grounded = false;
			jmp_count--;
		}
	}
}

// Check to see if we've just landed and store the step
if(grounded && !groundedLast) 
{
	landingStep = currentStep
}

groundedLast = grounded;

// Calculate the difference between current speed and desired speed and apply acceleration to get there. Higher xAccel means snappier acceleration
speed_x += (spd_wanted - speed_x) * cur_x_accel;

// Always use integers for movement. To keep things smooth, save the fractional part of movement and add at the start of each step
speed_x += xsp_fraction;
speed_y += ysp_fraction;

xsp_fraction = speed_x - (floor(abs(speed_x)) * sign(speed_x));
speed_x -= xsp_fraction;

ysp_fraction = speed_y - (floor(abs(speed_y)) * sign(speed_y));
speed_y -= ysp_fraction;


var ysp = speed_y;
var xsp = speed_x;
var next_tile;

// X Collision
if(xsp > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
p1 = tilemap_get_at_pixel(colTiles,bbox_side+xsp,bbox_top);
p2 = tilemap_get_at_pixel(colTiles,bbox_side+xsp,bbox_bottom);
next_tile = tilemap_get_at_pixel(colTiles,(bbox_side+xsp) + (TILE_SIZE * -sign(xsp)), bbox_bottom);
if (tilemap_get_at_pixel(colTiles,x,bbox_bottom) > 1) p2 = 0;
if (p1 == 1) || (p2 == 1)
{
	if(next_tile == 0) 
	{
		if (xsp > 0) x = x - (x % TILE_SIZE) + (TILE_SIZE - 1) - (bbox_right - x);
		else x = x - (x mod TILE_SIZE) - (bbox_left - x);
		xsp = 0;
		speed_x = 0;
		can_wall_jump = !grounded;
		wall_jmp_direction = sign(xsp); 
	} else 
	{
		can_wall_jump = false;
	}
} else {
	can_wall_jump = false;
}

x += xsp;


// Y collision
// Check to see if we have collided with no tile or a solid tile
if (tilemap_get_at_pixel(colTiles,x,bbox_bottom+ysp) <= 1)
{
	// If traveling down, check bottom collisions. If up, check top collisions
	if (ysp >= 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
	// Returns id of tile that each corner we're checking has collided with. Assuming no tile manipulations, tile 1 is solid
	p1 = tilemap_get_at_pixel(colTiles,bbox_left,bbox_side+ysp);
	p2 = tilemap_get_at_pixel(colTiles,bbox_right,bbox_side+ysp);
	if (p1 == 1) || (p2 == 1)
	{
		// If moving down, set y to top of the tile we've collided with
		if (ysp >= 0) y = y - (y % TILE_SIZE) + (TILE_SIZE - 1) - (bbox_bottom - y);
		// If moving up, set y to bottom of the tile we've collided with
		else y = y - (y % TILE_SIZE) - (bbox_top - y);
		// Set this yspeed to 0, since we've already handled our y movement
		ysp = 0;
		speed_y = 0;
	}
}

// Check for slope collisions. First find if we've colided with a slope, and how many pixels into the tile the collision we've sunk
floordist = InFloor(colTiles,x,bbox_bottom+ysp);
if(floordist >= 0)
{
	// If we've collided with a slope tile, set our y coord to the height of the slope at our x (plus one for a buffer)
	y += ysp;
	y -= (floordist + 1);
	// Set yspeed to 0 and floordist to -1 because we're now one pixel over the floor
	ysp = 0;
	speed_y = 0;
	floordist = -1;
	
}

// Add yspeed if there is any to update our position
y += ysp;


// Handle downhill movement for smoothness. If we started the frame on the ground and haven't jumped, we should still be on the ground (no bounce down)

if (grounded) 
{
	// Check to see if we're at the bottom of a sloped tile
	y += abs(floordist) - 1;
	if ((bbox_bottom % TILE_SIZE) == TILE_SIZE - 1)
	{
		// If so, 
		if (tilemap_get_at_pixel(colTiles,x,bbox_bottom+1) > 1)
		{
			y += abs(InFloor(colTiles,x,bbox_bottom+1));
		}
	}
}

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
			jmp_count = 1;
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
			var index = floor(crouch_count / 5);
			if(index >= array_length_1d(jmp_inc_table))
			{
				index = array_length_1d(jmp_inc_table) - 1;
			}
			var addition = jmp_inc_table[index];
			show_debug_message("Index: " + string(index) + " Inc: " + string(addition));
			jumpImpulse += addition;
			crouch_count++;
			if(jumpImpulse <= jumpSpd) 
			{
				jumpImpulse = jumpSpd;
			}
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





currentStep++;

deltaX = x - lastX;
lastX = x;
// Check direction
image_xscale = sign(xsp);
if(image_xscale == 0) 
{
	image_xscale = lastDir;
}
lastDir = image_xscale;

if(bbox_top >= room_height)
{
	room_restart();
}
show_debug_message("jump: " + string(jumpImpulse));