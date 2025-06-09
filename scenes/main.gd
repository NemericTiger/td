extends Node2D


var current_wave = 0

func _ready() -> void:
	get_node("PathSpawner/Timer").stop()
	


func start_next_wave():
	get_node("PathSpawner/Timer").start()
