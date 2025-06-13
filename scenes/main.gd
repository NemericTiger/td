extends Node2D

var towers
var current_wave = 0

func _ready() -> void:
	get_node("PathSpawner/Timer").stop()
	
	

func _unhandled_input(event: InputEvent) -> void:
	towers = get_node("Towers")
	if event is InputEventMouseButton and event.button_mask == 1:
		for i in towers.get_child_count():
			towers.get_child(i).get_node("Upgrade/Upgrade").hide()
			towers.get_child(i).get_node("Tower/CollisionShape2D2").hide()
	#elif event == "ui_focus_next":
		#get_node("UI/Panel")


func start_next_wave():
	get_node("PathSpawner/Timer").start()
