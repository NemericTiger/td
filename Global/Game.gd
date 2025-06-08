extends Node


var Gold = 100
var Health = 2

signal Soldier_A_dead

func _process(_delta: float) -> void:
	if Health <= 1:
		Health = 10
		Gold = 100
		get_tree().change_scene_to_file("res://deathscreen.tscn")
