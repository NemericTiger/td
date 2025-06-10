extends CharacterBody2D

@export var speed = 200
@export var Health = 10
@onready var health_bar = get_node("ProgressBar")



func _ready() -> void:
	#health_bar.set_as_toplevel(true)
	pass

func _process(delta: float):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() >= 0.99:
		Game.Health -= 1
		death()

	elif Health <= 0:
		Game.Gold += 1
		death()


func death():
	get_parent().get_parent().queue_free()
