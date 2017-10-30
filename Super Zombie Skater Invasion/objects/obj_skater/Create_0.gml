/// @description Insert description here
// You can write your code in this editor

// Animation states
ANIM_IDLE = 0;
ANIM_SKATE = 1;
ANIM_CROUCH = 2;
ANIM_JUMP = 3;
ANIM_FALL = 4;
ANIM_BAIL = 5;
ANIM_FLIP = 6;
ANIM_SLAM = 7;

// state variables
animState = 0;

// Movement variables
hsp = 0;
vsp = 0;
lastDir = 1;


// Movement constants
skateSpd = 3;
grv = 0.9;
jmpSpd = -13;
