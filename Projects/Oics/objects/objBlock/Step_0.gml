/// @description 
gridPos.x = x div GRID_W;
gridPos.y = y div GRID_H;

if (fadeOut)
{
	image_alpha -= 0.1;
	if (image_alpha <= 0) instance_destroy();
}