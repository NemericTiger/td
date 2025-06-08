extends CharacterBody2D


var target
var Speed = 3000
var pathName = ""
var bulletDamage
var curr = true

func _ready() -> void:
	Game.connect("Soldier_A_dead", delete)

func delete():
	curr = false


func _physics_process(_delta: float):
	var pathSpawnerNode = get_tree().get_root().get_node("Main/PathSpawner")
	
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position

	if curr == true:
		velocity = global_position.direction_to(target) * Speed


	look_at(target)
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if "Soldier_A" in body.name:
		body.Health -= bulletDamage
		queue_free()
