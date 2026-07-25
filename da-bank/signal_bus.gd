extends Node

signal _bomb_time_updated(time_left: float)
signal _bomb_defused()
signal _bomb_exploded()

signal _pick_up_object(player : Player, object : PickUpObject)
signal _put_down_object(player : Player, object : PickUpObject)

signal _object_in_truck(value : float, object : PickUpObject)
