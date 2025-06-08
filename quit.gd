extends Button

func _ready() -> void:
	grab_focus()

func _on_pressed() -> void:
	get_tree().quit()
