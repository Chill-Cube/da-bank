extends Node

signal _bomb_time_updated(time_left: float)
signal _bomb_defused()
signal _bomb_exploded()
signal _plant_bomb()
signal _bomb_planted()
signal _bomb_planted0()

signal _pick_up_object(player : Player, object : PickUpObject)
signal _put_down_object(player : Player, object : PickUpObject)

signal _object_in_truck(value : float, object : PickUpObject)

signal _play_cutscene(duration : float)
signal _play_bars()
signal _end_cutscene()
signal _death_cutscene()
signal _leave_cutscene()
