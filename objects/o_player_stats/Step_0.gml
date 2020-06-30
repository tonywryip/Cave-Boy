/// @desc <>
if (keyboard_check_pressed(vk_space) and room == r_title) {
	room_goto(r_1);
	audio_stop_sound(a_title);
	audio_play_sound(a_cave, 10, true);
}

//Change music
if (!audio_is_playing(a_title) and !audio_is_playing(a_cave)) {
	audio_play_sound(a_cave, 10, true);
}

//restart room
if (keyboard_check_pressed(ord("R"))) {
	room_restart();
	hp = 3;
	sapphires = 0;
}

#region go to room
if (keyboard_check_pressed(ord("1"))) {
	room_goto(r_1);
	hp = 3;
	sapphires = 0;
}

if (keyboard_check_pressed(ord("2"))) {
	room_goto(r_2);
	hp = 3;
	sapphires = 0;
}

if (keyboard_check_pressed(ord("3"))) {
	room_goto(r_boss);
	hp = 3;
	sapphires = 0;
}
#endregion