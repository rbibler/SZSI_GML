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

xsp_fraction = 0;
ysp_fraction = 0;

deltaX = 0;
lastX = 0;


jmp_inc_table[0] = -0.5;
jmp_inc_table[1] = -0.25;
jmp_inc_table[2] = -0.125;
jmp_inc_table[3] = -0.075;
jmp_inc_table_length = 8;
// Movement constants
skateSpdMax = 5.25;
xAccel = 0.45;
yAccel = .925;
jumpSpd = -16;

jumpImpulseInc = -.75;
jumpImpulse = -10;
jumpImpulseMin = -10;
can_wall_jump = 0;
wall_jmp_direction = 0;
jmp_count = 1;

currentStep = 0;
landingStep = 0;
groundedLast = false;
crouch_count = 0;
// Collision attributes
colTiles = layer_tilemap_get_id("collision_tiles");