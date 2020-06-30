/// @desc <>

#region Setup controls
right = keyboard_check(vk_right);
left = keyboard_check(vk_left);
up = keyboard_check(vk_up);
down = keyboard_check(vk_down);
up_release = keyboard_check_released(vk_up);
#endregion

#region State Machine
switch (state) {
#region Moving state
	case player.moving:
		//Sprite Change player idle/walk
		if (xspeed == 0) {
			sprite_index = s_player_idle;
		} else {
			sprite_index = s_player_walk;
		}
		
		//Check if player is in the air
		if (!place_meeting(x, y + 1, o_solid)){
			yspeed += gravity_acceleration;
			
			//Sprite Change player jump
			sprite_index = s_player_jump;
			image_index = (yspeed > 0);
			
			//Control the jump height
			if (up_release and yspeed < -6) {
				yspeed = -3;
			}
		} else {
			yspeed = 0;
			
			//Jump
			if (up) {
				yspeed = jump_height;
				audio_play_sound(a_jump, 5, false);
			}
		}
		//Change direction of sprite
		if (xspeed != 0) {
			image_xscale = sign(xspeed);
		}
		//check for moving left or right
		if (right or left) {
			xspeed += (right - left) * acceleration;
			xspeed = clamp(xspeed, -max_speed, max_speed);
		} else {
			apply_friction(acceleration);
		}
		
		//Landing sound
		if (place_meeting(x, y + yspeed + 1, o_solid) and yspeed >0){
			audio_play_sound(a_land, 5, false);
		}
		
		move(o_solid);
		
		//Check for ledge grab state
		var _falling = y - yprevious > 0;
		var _wasnt_wall = !position_meeting(x + grab_width * image_xscale, yprevious, o_solid);
		var _is_wall = position_meeting(x + grab_width * image_xscale, y, o_solid);
		
		if (_falling and _wasnt_wall and _is_wall) {
			xspeed = 0;
			yspeed = 0;
			
			//move against the ledge
			while (!place_meeting(x + image_xscale, y, o_solid)){
				x += image_xscale;
			}
			
			//Check vertical Position
			while (position_meeting(x + grab_width * image_xscale, y - 1, o_solid)){
				y -= 1
			}
			
			//Change sprite and state
			sprite_index = s_player_ledge_grab;
			state = player.ledge_grab;
			
			audio_play_sound(a_land, 6, false);
		}
		
	break;
#endregion
#region Ledge grab state
	case player.ledge_grab:
		if (down) {
			state = player.moving;
		}
		if (up) {
			state = player.moving;
			yspeed = jump_height;
		}
	break;
#endregion
#region Door state
	case player.door:
		sprite_index = s_player_exit;
		//Fade out
		if (image_alpha > 0) {
			image_alpha -= 0.1;
		} else {
			//go to next room
			room_goto_next();
		}
	break;
#endregion
#region Hurt state
	case player.hurt:
		sprite_index = s_player_hurt;
		
		if (xspeed != 0) {
			image_xscale = sign(xspeed);
		}
		if (!place_meeting(x, y + 1, o_solid)){
			yspeed += gravity_acceleration;
		} else {
			yspeed = 0;
			apply_friction(acceleration);
		}
		direction_move_bounce(o_solid);
		
		//change back to other state
		if (xspeed == 0 and yspeed == 0){
			if (o_player_stats.hp <= 0) {
				state = player.death;
			} else {
				image_blend = c_white;
				state = player.moving;
			}
		}
	break;
#endregion
#region Death state
	case player.death:
		with (o_player_stats) {
			hp = max_hp;
			sapphires = 0;
		}
		
		room_restart();
	break;
#endregion
}
#endregion