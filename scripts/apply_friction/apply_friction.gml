/// @description apply_friction(amount)
/// @param amount

var _amount = argument0;

//First check if we are moving
if (xspeed != 0) {
	if (abs(xspeed) - _amount > 0) {
		xspeed -= _amount * image_xscale;
	} else {
		xspeed = 0;
	}
}