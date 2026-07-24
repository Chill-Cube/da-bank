extends Node

signal _bomb_time_updated(time_left: float)
signal _bomb_defused()
signal _bomb_exploded()

signal _pick_up_object(player : Player, object : Node2D)
signal _put_down_object(player : Player, object : Node2D)
