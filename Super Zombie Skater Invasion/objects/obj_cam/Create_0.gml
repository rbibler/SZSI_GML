/// @description Insert description here
// You can write your code in this editor
cam = view_camera[0];
follow = obj_skater;
width = camera_get_view_width(cam);
height = camera_get_view_height(cam);
half_width = width / 2;
half_height = height / 2;
xTo = xstart;
yTo = ystart;
deltaX = 0;
lastX = 0;