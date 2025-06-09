extends Node

func _ready() -> void:
	get_node("MainMenu/HBoxContainer/Play").connect("pressed", on_play_pressed)
	get_node("MainMenu/HBoxContainer/Quit").connect("pressed", on_quit_pressed)


func on_play_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://scenes/main.tscn").instantiate()
	add_child(game_scene)

func on_restart_pressed():
	get_node("Deathscreen").queue_free()
	var game_scene = load("res://scenes/main.tscn").instantiate()
	add_child(game_scene)

func on_quit_pressed():
	get_tree().quit()


func _process(_delta: float) -> void:
	if Game.Health < 1:
		Game.Health = 10
		Game.Gold = 100
		deathscreen()


func deathscreen():
	get_node("Main").queue_free()
	var deathscreen = load("res://scenes/deathscreen.tscn").instantiate()
	add_child(deathscreen)
	get_node("Deathscreen/HB/Restart").connect("pressed", on_restart_pressed)
	get_node("Deathscreen/HB/Quit").connect("pressed", on_quit_pressed)
