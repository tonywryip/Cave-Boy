/// @description move(collision_object)
/// @arg collision_object

var _collision_object = argument0;

//Horizonyal Collisions
pp_collision(0, _collision_object);

x += xspeed;

//Vertical Collisions
pp_collision(1, _collision_object);

y += yspeed;