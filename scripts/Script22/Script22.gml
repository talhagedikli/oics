function Block() constructor
{
    gridPos = new Vector2(x div GRID_W, y div GRID_H);
    
    static update = function()
    {
        gridPos.x = x div GRID_W;
        gridPos.y = y div GRID_H;
    }
}
function Grid(_x, _y, _color = c_white, _alpha = 1, _xScale = 1, _yScale = 1) constructor
{
    x       = _x;
    y       = _y;
    color   = _color;
    alpha   = _alpha;
	xScale	= _xScale;
	yScale	= _yScale;
	
	set = function(_x, _y)
	{
		x = _x;
		y = _y;
	}
	
	blend = function(_color, _alpha)
	{
		color = _color;
		alpha = _alpha;
	}
	
	scale = function(_xScale, _yScale)
	{
		xScale	= _xScale;
		yScale	= _yScale;
	}
}