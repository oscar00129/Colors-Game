extends CanvasLayer
class_name GameOverScreen

func _ready() -> void:
	$AudioStreamPlayer.play()
	$VBoxContainer/lblScore.text = "Puntaje: " + str(global.score)

# Opens the main game screen
func _on_btn_re_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")

# Opens the start menu screen
func _on_btn_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
