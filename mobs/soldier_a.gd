extends CharacterBody2D

@export var speed = 300

func _process(delta: float):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 0.99:
		queue_free()
