/// @description Insert description here
// You can write your code in this editor
skyX = round(camera_get_view_x(view_camera[0]) / 1.0001);
if(abs(skyX - lastSkyX) >= maxSkyXUpdate) 
{
	skyX += sign(skyX - lastSkyX) * maxSkyXUpdate;
}
lastSkyX = skyX;
layer_x("bg_skyLayer", skyX);