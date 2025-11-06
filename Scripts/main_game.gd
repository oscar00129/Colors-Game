extends CanvasLayer

# Variables to control the game flow
var user_input_array:Array[int]
var cpu_input_array:Array[int]
var score:int

# Signals to enable or disable buttons
signal can_click_signal
signal cannot_click_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

# Start game initializing all the variables used.
func start_game():
	user_input_array = []
	cpu_input_array = []
	score = 0
	$GridContainer/BlueButton/AnimationPlayer.play("idle")
	$GridContainer/GreenButton/AnimationPlayer.play("idle")
	$GridContainer/RedButton/AnimationPlayer.play("idle")
	$GridContainer/YellowButton/AnimationPlayer.play("idle")

# Resets user input to play in the turn
func reset_user_input_array():
	user_input_array = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$GameInterface/Score.text = "Puntaje: " + str(score)

# Reads user's button input
func _on_button_index_clicked(index: int) -> void:
	user_input_array.append(index)
	if cpu_input_array.size() < 1:
		cpu_input_array.append(index)
		score += 1
		add_random_number_to_cpu_input_array()
		reset_user_input_array()
		play_animation_sequence()
	else:
		for i in range(user_input_array.size()):
			if user_input_array[i] != cpu_input_array[i]:
				game_over()
				return
		if user_input_array.size() == cpu_input_array.size():
			score += 1
			add_random_number_to_cpu_input_array()
			reset_user_input_array()
			play_animation_sequence()

# Adds a random number into cpu arrays queue
func add_random_number_to_cpu_input_array():
	var random_index = randi() % 4
	cpu_input_array.append(random_index)

# Shows a Game Over Screen
func game_over():
	global.score = score
	get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")

# Play an animation of the cpu's button sequence
func play_animation_sequence():
	cannot_click_signal.emit()
	await get_tree().create_timer(0.25).timeout
	
	for i in cpu_input_array:
		var anim_player:AnimationPlayer
		match i:
			0:
				anim_player = $GridContainer/BlueButton/AnimationPlayer
			1:
				anim_player = $GridContainer/GreenButton/AnimationPlayer
			2: 
				anim_player = $GridContainer/RedButton/AnimationPlayer
			3:
				anim_player = $GridContainer/YellowButton/AnimationPlayer
		anim_player.play("click")
		await anim_player.animation_finished
	
	can_click_signal.emit()
