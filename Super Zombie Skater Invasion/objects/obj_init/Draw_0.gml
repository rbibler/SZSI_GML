/// @description Insert description here
// You can write your code in this editor

draw_tilemap(tilemapid,0,0);

for (var i = heightstoget - 1; i >= 0; i--) 
{
	var check = 0;
	while (check <= TILE_SIZE)
	{
		global.heights[i] = check;
		if (check == TILE_SIZE) break;
		if (surface_getpixel(application_surface,i,check) != c_black) break;
		check++;
	}
}


room_goto_next();
