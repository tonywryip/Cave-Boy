///@arg hor=0/ver=1
///@arg collision_object

var _direction = argument0
var _collision_object = argument1

if _direction == 0 {
	if (place_meeting(x + xspeed, y, _collision_object)){
		while (!place_meeting(x + sign(xspeed), y, _collision_object)){
			x += sign(xspeed);
		}
		xspeed = 0;
	}
} else {
	if (place_meeting(x, y + yspeed, _collision_object)){
	while (!place_meeting(x, y + sign(yspeed), _collision_object)){
		y += sign(yspeed);
	}
	yspeed = 0;
	}
}