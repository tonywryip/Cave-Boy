/// @desc <>

//set spider to be still
image_speed = 0;
image_index = 0;

sight = 128;
max_speed = 4;
acceleration = 1.5;
gravity_acceleration = 0.5;

enum spider {
	idle,
	jump
}

state = spider.idle;