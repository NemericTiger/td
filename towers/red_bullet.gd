class_name Bullet
extends CharacterBody2D

var target_position
var target
var Speed = 3000
var pathName = ""
var bulletDamage
var curr = true

#func _ready():
	#Game.connect("Soldier_A_dead", delete)

#func delete():
	#print("dead")
	#self.free()


func _physics_process(_delta: float):
	var pathSpawnerNode = get_tree().get_root().get_node("SceneHandler/Main/PathSpawner")
	
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target_position = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0)

	if target != null:
		velocity = global_position.direction_to(target_position) * Speed
		look_at(target_position)
	
		move_and_slide()

	else:
		self.free()




func _on_area_2d_body_entered(body):
	if "Soldier_A" in body.name:
		body.Health -= bulletDamage
		queue_free()
