/// @description Checks to see if position is below the floor height of a given tile, returns how deep in floor
/// @arg tilemap
/// @arg x
/// @arg y

var pos = tilemap_get_at_pixel(argument0,argument1,argument2);
if (pos > 0)
{
	if (pos == 1) return (argument2 % TILE_SIZE);
	var thefloor = global.heights[(argument1 % TILE_SIZE) + (pos * TILE_SIZE)];
	return ((argument2 % TILE_SIZE) - thefloor);
} else return -(TILE_SIZE - (argument2 % TILE_SIZE));
