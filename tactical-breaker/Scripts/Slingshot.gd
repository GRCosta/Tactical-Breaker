extends Node2D

@export var max_velocity: float = 800.0
@export var trajectory_dots: int = 20

var is_dragging: bool = false
var start_touch_pos: Vector2
var current_direction: Vector2


func _ready():
	print("Slingshot is alive and waiting...")
	# Force state to AIM if GameManager isn't doing it yet
	if GameManager.current_state != GameManager.GameState.AIM:
		GameManager.change_state(GameManager.GameState.AIM)

func _input(event: InputEvent) -> void:
	#___DEBUG___#
	#if event is InputEventMouseButton and event.pressed:
	#	print("Mouse clicked at: ", event.position)
	#
	## Only allow aiming if the GameManager is ready
	#if GameManager.current_state != GameManager.GameState.AIM:
	#	return
	#if event is InputEventScreenTouch or event is InputEventMouseButton:
	#	if event.pressed:
	#		is_dragging = true
	#		start_touch_pos = event.position
	#	elif is_dragging:
	#		is_dragging = false
	#		launch_ball()
	#	if event is InputEventScreenDrag or event is InputEventMouseMotion:
	#		if is_dragging:
	#			update_trajectory(event.position)
	if event is InputEventMouseButton and event.pressed:
		print("1. Mouse Click Detected")
		if GameManager.current_state != GameManager.GameState.AIM:
			print("   - FAILED: GameManager state is: ", GameManager.GameState.keys()[GameManager.current_state])
			return
		
		is_dragging = true
		start_touch_pos = event.position

	elif event is InputEventMouseButton and not event.pressed and is_dragging:
		print("2. Mouse Released")
		is_dragging = false
		launch_ball()			

func update_trajectory(touch_pos:Vector2):
	var drag_vec = start_touch_pos - touch_pos
	current_direction= drag_vec.normalized()
	queue_redraw()

func launch_ball():
	## Main scene spawn and fire the ball
	#var main_node = get_tree().root.find_child("Main", true, false)
	#
	#if main_node:
	#	main_node.spawn_and_launch(current_direction)
	#	GameManager.change_state(GameManager.GameState.ACTION)
	#else:
	#	print("ERROR: Slingshot could not find the Main Node!!")
	print("3. Attempting to Launch...")
	var main_node = get_tree().root.find_child("Main", true, false)
	if main_node:
		print("4. Main Node Found! Calling spawn_and_launch")
		main_node.spawn_and_launch(current_direction)
		GameManager.change_state(GameManager.GameState.ACTION)
	else:
		print("4. ERROR: Main Node NOT found in the tree!")
	
