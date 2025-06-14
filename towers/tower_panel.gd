extends Panel

@export var tower_type : String
@export var tier : String
@export var texture : Texture
@onready var tower = load("res://towers/" + tower_type + tier + ".tscn")
var currTile
var cost

var tower_count = 0


func _ready():
	cost = Game.tower_data[tower_type + tier]["cost"]
	get_node("Control/Label").text = str(cost)
	#get_node("TowerSprite").scale = 0.3
	get_node("Control/TowerSprite").set_texture(texture)

func _on_gui_input(event: InputEvent) -> void:
	if Game.Gold >= cost:
		var tempTower = tower.instantiate()
		tempTower.set_name(str(tower_type) + str(tower_count))
		tempTower.tower_name = str(tower_type) + str(tower_count)
		tempTower.type = tower_type
		tempTower.tier = tier
		if event is InputEventMouseButton and event.button_mask == 1:
			#mb1 down
			add_child(tempTower)
			tempTower.global_position = event.global_position
			tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			tempTower.scale = Vector2(0.32, 0.32)
			get_child(1).get_node("Area").size.x = Game.tower_data[tower_type + tier]["range"]
			get_child(1).get_node("Area").size.y = Game.tower_data[tower_type + tier]["range"]
			get_child(1).get_node("Area").position.x = - Game.tower_data[tower_type + tier]["range"]
			get_child(1).get_node("Area").position.y = - Game.tower_data[tower_type + tier]["range"]
		elif event is InputEventMouseMotion and event.button_mask == 1:
			#if get_child_count() > 1:
			get_child(1).global_position = event.global_position
			var mapPath = get_tree().get_root().get_node("SceneHandler/Main/Layer0")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(tile)
			var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()

			if currTile == Vector2i(4,5) and event.global_position.x < 2944:
				if targets.size() > 0:
					get_child(1).get_node("Area").modulate = Color(255,0,0)
				else:
					get_child(1).get_node("Area").modulate = Color(0,255,0)

			else:
				get_child(1).get_node("Area").modulate = Color(255,0,0)
			
			
		elif event is InputEventMouseButton and event.button_mask == 0:
			if event.global_position.x >= 2944:
				if get_child_count() > 1:
					get_child(1).queue_free()
			else:
				if get_child_count() > 1:
					get_child(1).queue_free()
					
				if currTile == Vector2i(4,5):
					var path = get_tree().get_root().get_node("SceneHandler/Main/Towers")
					var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
					if targets.size() < 1:
						path.add_child(tempTower)
						tower_count += 1
						tempTower.global_position = event.global_position
						tempTower.get_node("Area").hide()

						tempTower.on_built()
						
						
						Game.Gold -= cost
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
