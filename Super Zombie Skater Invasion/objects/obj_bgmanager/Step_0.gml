/// @description Insert description here
// You can write your code in this editor

var camX = camera_get_view_x(view_camera[0]);
var closeX = camX / closeScroll;
var midX = camX / midScroll;
var skyX = camX / skyScroll;
layer_x(closeLayer, closeX);
layer_x(midLayer, midX);
layer_x(skyLayer, skyX);