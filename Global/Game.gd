extends Node


var Gold = 100
var Health = 20

signal Soldier_A_dead

func _ready() -> void:
	Game.Soldier_A_dead.emit()
