/// @desc <>
repeat (irandom_range(4,7)) {
	var _rand_x = irandom_range(-4, 4);
	var _rand_y = irandom_range(-4, 4);
	var particle = instance_create_layer(x + _rand_x, y + _rand_y, "Enemies", o_particle);
	particle.image_blend = c_red;
	particle.image_speed = 0.25;
}