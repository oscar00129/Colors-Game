extends CanvasLayer

# Opens the main game screen
func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")
