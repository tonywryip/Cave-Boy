/// @description move(collision_object)
/// @arg collision_object

var _collision_object = argument0;

//Horizonyal Collisions
	if (place_meeting(x + xspeed, y, _collision_object)){
		while (!place_meeting(x + sign(xspeed), y, _collision_object)){
			x += sign(xspeed);
		}
		xspeed = -(xspeed / 10);
	}

x += xspeed;

//Vertical Collisions
	if (place_meeting(x, y + yspeed, _collision_object)){
		while (!place_meeting(x, y + sign(yspeed), _collision_object)){
			y += sign(yspeed);
		}
		yspeed = -(yspeed / 10);
		if (abs(yspeed) <2) {
			yspeed = 0;
		}
	}

y += yspeed;