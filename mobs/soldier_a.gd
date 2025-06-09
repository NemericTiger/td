extends CharacterBody2D

@export var speed = 200
@export var Health = 10

func _process(delta: float):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() >= 0.99:
		Game.Health -= 1
		death()

	elif Health <= 0:
		Game.Gold += 1
		death()


func death():
	Game.Soldier_A_dead.emit()
	#for i in get_tree().get_root().get_nodes_in_group("Bullet"):
		#if i.pathName == get_parent().name:
			#i.queue_free()
	#
	#
	#
	get_parent().get_parent().queue_free()
