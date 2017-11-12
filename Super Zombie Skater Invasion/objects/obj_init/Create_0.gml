/// @description Insert description here
// You can write your code in this editor
#macro TILE_SIZE 16

heightstoget = sprite_get_width(spr_colTiles);
tiles = heightstoget / TILE_SIZE;

//Create tiles
var layerid = layer_create(0,"Tiles");
tilemapid = layer_tilemap_create(layerid,0,0,tCollision,tiles,1);

for (var i = 0; i <= tiles; i++) 
{
	tilemap_set(tilemapid,i,i,0);
}