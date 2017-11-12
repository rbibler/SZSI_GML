/// @description Insert description here
// You can write your code in this editor

// Update destination
if(instance_exists(follow))
{
	xTo = follow.x;
	yTo = follow.y;
}

// Update object position
x += (xTo - x) / 1;
y += (yTo - y) / 1;

x = clamp(x,half_width,room_width-half_width);
y = clamp(y,half_height,room_height-half_height);

// Update camera view
camera_set_view_pos(cam,x-half_width,y-half_height);
deltaX = x - lastX;
lastX = x;