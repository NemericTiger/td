extends Panel

@onready var tower = preload("res://towers/red_tower.tscn")
var currTile

func _on_gui_input(event: InputEvent) -> void:
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#mb1 down
		add_child(tempTower)
		#tempTower.global_position = event.global_position
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
	if event is InputEventMouseMotion and event.button_mask == 1:
		get_child(1).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		print("mb1 unclick")
		get_child(1).queue_free()
		var path = get_tree().get_root().get_node("Main")
		
		path.add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.get_node("Area").hide()
