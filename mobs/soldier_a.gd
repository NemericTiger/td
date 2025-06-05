extends CharacterBody2D

@export var speed = 200
var Health = 10

func _process(delta: float):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 0.99:
		queue_free()
	elif Health <= 0:
		get_parent().get_parent().queue_free()
