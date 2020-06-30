/// @desc <>

switch (state){
	#region Idle state
	case boss.idle:
		var _dis = point_distance(x, y, o_player.x, o_player.y);
		if (_dis <= sight) {
			state = boss.lift;
		}
	break;
	#endregion
	#region lift state
	case boss.lift:
		image_index = 1;
		yspeed = -3.5;
		move(o_solid);
		if (place_meeting(x, y - 64, o_solid)){
			yspeed = 0;
			state = boss.chase;
		}
	break;
	#endregion
	#region chase state
	case boss.chase:
		image_index = 0;
		
		var _dis = point_distance(x, y, o_player.x, y);
		var _wall_left = place_meeting(x - 1, y, o_solid);
		var _wall_right = place_meeting(x + 1, y, o_solid);
		if (_dis < (sprite_width / 2 - 16) or _wall_left or _wall_right) {
			state = boss.smash;
			audio_play_sound(a_jump, 6, false);
			xspeed = 0;
		} else {
			xspeed = (o_player.x - x) * 0.04;
		}
		move(o_solid);
	break;
	#endregion
	#region smash state
	case boss.smash:
		image_index = 1;
		
		if (!place_meeting(x, y + 1, o_solid)) {
			if (yspeed < 16) {
				yspeed += 0.5;
			}
			move(o_solid);
		} else {
			state = boss.stall;
			alarm[0] = room_speed;
			audio_play_sound(a_land, 8, false);
			
			if (place_meeting(x, y, o_lava)) {
				hp -= 1;
				audio_play_sound(a_snake, 9, false);
			}
		}
	break;
	#endregion
	#region stall state
	case boss.stall:
		if (alarm[0] == -1) {
			state = boss.lift;
		}
	break;
	#endregion
}

if (place_meeting(x, y, o_lava)) {
	image_blend = c_red;
} else {
	image_blend = c_white;
}

//kill boss
if (hp <= 0) {
	repeat (50) {
		var _particle = instance_create_layer(bbox_left + random(sprite_width - 24), bbox_top + random(sprite_height), "Lava", o_particle);
		_particle.image_blend = c_red;
	}
	instance_destroy();
}