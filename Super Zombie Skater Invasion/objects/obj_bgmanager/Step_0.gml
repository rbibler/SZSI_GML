/// @description Insert description here
// You can write your code in this editor

var camX = camera_get_view_x(view_camera[0]);
var skyX = camX / 1.05;
var midX = camX / 1.75;
layer_x("bg_skyLayer", skyX);
layer_x("bg_midLayer", midX);