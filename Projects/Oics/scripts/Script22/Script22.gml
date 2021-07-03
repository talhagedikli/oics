function Block() constructor
{
    gridPos = new Vector2(x div GRID_W, y div GRID_H);
    
    static update = function()
    {
        gridPos.x = x div GRID_W;
        gridPos.y = y div GRID_H;
    }
    
    //static destroy = function()
    //{
    //    delete self;
    //}
}
function Grid(_x, _y, _color = c_white, _alpha = 1) constructor
{
    x       = _x;
    y       = _y;
    color   = _color;
    alpha   = _alpha;
	
	set = function(_x, _y)
	{
		x = _x;
		y = _y;
	}
}