extends TextureButton

# The index used for this button
@export var button_index:int

# Signal to emit a signal of this button being clicked
signal button_index_clicked(index:int)

# Emit a signal
func _on_pressed() -> void:
	$AudioStreamPlayer.play()
	button_index_clicked.emit(button_index)

# Signal when an animation is finished
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "click":
		$AnimationPlayer.play("idle")

# Reads a can click signal
func _on_main_game_can_click_signal() -> void:
	disabled = false

# Reads a cannot click signal
func _on_main_game_cannot_click_signal() -> void:
	disabled = true


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "click":
		await get_tree().create_timer(0.6).timeout
		$AudioStreamPlayer.play()
