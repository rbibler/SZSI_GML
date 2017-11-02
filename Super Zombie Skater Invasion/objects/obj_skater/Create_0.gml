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
speed_x = 0;
speed_y = 0;
lastDir = 1;

deltaX = 0;
lastX = 0;


// Movement constants
skateSpdMax = 5;
xAccel = 0.2;
yAccel = 0.9;
jumpSpd = -13;
jumpImpulseInc = -0.5;
jumpImpulse = -5;
jumpImpulseMin = -5;

currentStep = 0;
landingStep = 0;
groundedLast = false;

// Collision attributes
colTiles = layer_tilemap_get_id("collision_tiles");