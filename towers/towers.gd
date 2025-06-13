extends StaticBody2D

var type
var tier
var Bullet
var bulletDamage
var pathName
var currTargets = []
var curr
var tower_ready = true
var tower_name
var rof : float
var max_rof
var range

@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var startShooting = false

func _ready() -> void:
	bulletDamage = Game.tower_data[type + tier]["damage"]
	Bullet = load("res://towers/bullets/" + type + tier + "_bullet.tscn")
	rof = Game.tower_data[type + tier]["rof"]
	max_rof = Game.tower_data[type + tier]["max_rof"]
	range = Game.tower_data[type + tier]["range"]
	get_node("Upgrade/Upgrade").hide()
	get_node("Upgrade/ProgressBar").hide()
	get_node("Upgrade/ProgressBar").global_position = self.global_position + Vector2(-32, 55)
	get_node("Tower").connect("body_entered", _on_tower_body_entered)
	get_node("Tower").connect("body_exited", _on_tower_body_exited)
	get_node("Upgrade/Upgrade/HBoxContainer/AttackSpeed").connect("pressed", _on_attack_speed_pressed)
	get_node("Upgrade/Upgrade/HBoxContainer/Power").connect("pressed", _on_power_pressed)
	get_node("Upgrade/ProgressBar/Timer").connect("timeout", _on_timer_timeout)
	get_node("TowerDetector").connect("input_event", _on_input_event)
	update_powers()



func on_built():

	get_node("Upgrade/ProgressBar/Timer").wait_time = rof
	get_node("Tower/CollisionShape2D2").shape.radius = range
	update_powers()

func _process(_delta: float) -> void:
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		if timer.is_stopped():
			timer.start()
		if tower_ready:
			Shoot()
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()



func Shoot():
	tower_ready = false
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position


func _on_tower_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		for i in currTargets:
			if i.is_in_group("Enemies"):
				tempArray.append(i)
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		
		curr = currTarget
		pathName = currTarget.get_parent().name
		


func _on_tower_body_exited(_body):
	currTargets = get_node("Tower").get_overlapping_bodies()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("SceneHandler/Main/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-320, 81)
		get_node("Tower/CollisionShape2D2").visible = !get_node("Tower/CollisionShape2D2").visible


func _on_timer_timeout() -> void:
	get_node("Upgrade/ProgressBar").show()
	tower_ready = true


func _on_range_pressed() -> void:
	get_node("Tower/CollisionShape2D2").upgrade()
	#var control = Node.new()
	#control.set_name("Test")
	#var temp_range = range_upgrade.instantiate()
	#get_node("Tower/CollisionShape2D2/Range").add_child(control)
	#
	#get_node("Tower/CollisionShape2D2").upgrade()
	#get_parent().upgrade(tower_name)


func _on_attack_speed_pressed() -> void:
	if Game.Gold >= 10:
		if rof < max_rof:
			rof += 0.2
		elif rof >= max_rof - 0.2:
			rof = max_rof
		timer.wait_time = rof
		Game.Gold -= 10
		update_powers()


func _on_power_pressed() -> void:
	if Game.Gold >= 10:
		bulletDamage += 1
		Game.Gold -= 10
		update_powers()


func update_powers():
	get_node("Upgrade/Upgrade/HBoxContainer/Range/Label").text = str(range)
	get_node("Upgrade/Upgrade/HBoxContainer/AttackSpeed/Label2").text = str(rof)
	get_node("Upgrade/Upgrade/HBoxContainer/Power/Label3").text = str(bulletDamage)
	#var range_upgrade_count = get_node("Range").get_child_count()
	#get_node("Tower/CollisionShape2D2").shape.radius = range + range_upgrade_count * 30


func _on_range_mouse_entered() -> void:
	get_node("Tower/CollisionShape2D2").show()

func _on_range_mouse_exited() -> void:
	get_node("Tower/CollisionShape2D2").hide()
