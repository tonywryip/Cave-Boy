/// @desc initialize variable
window_set_fullscreen(true);

hp = 3;
max_hp = 3;
sapphires = 0;

display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

//Start the music
audio_play_sound(a_title, 10, false);

//get rid of curser
window_set_cursor(cr_none);

//randomize
randomize();